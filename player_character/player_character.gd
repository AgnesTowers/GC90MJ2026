extends CharacterBody2D
class_name PlayerCharacter

enum player_state{
	WALK,
	JUMP,
	ATTACK,
	DEAD
}


@export var jump_velocity : float = 50
@export var running_accel : float = 20.0
@export var running_max_speed : float = 120.0
@export var jump_cd : float = 1
@export var attack_cd : float = 1
@export var swap_cd : float = 1
@export var attack_duration : float = 1
@export var gravity_mult : float = 4

@onready var current_state : player_state = player_state.WALK
var is_in_mirror : bool = false

var attack_cooldown_timer : Timer
var jump_cooldown_timer : Timer
var swap_cooldown_timer : Timer

var attack_state_timer : Timer


func _ready() -> void:
	 
	%PlayerAnim.play("0")
	
	attack_cooldown_timer = Timer.new()
	attack_cooldown_timer.one_shot = true
	add_child(attack_cooldown_timer)
	jump_cooldown_timer = Timer.new()
	jump_cooldown_timer.one_shot = true
	add_child(jump_cooldown_timer)
	swap_cooldown_timer = Timer.new()
	swap_cooldown_timer.one_shot = true
	add_child(swap_cooldown_timer)

	attack_state_timer = Timer.new()
	attack_state_timer.one_shot = true
	add_child(attack_state_timer)
	attack_state_timer.timeout.connect(end_attack)

func _physics_process(_delta: float) -> void:
	DebugGlobal.set_debug_info("player state",player_state)
	DebugGlobal.set_debug_info("current state",current_state)
	if current_state != player_state.DEAD :
		DebugGlobal.set_debug_info("velocity",velocity)
		if velocity.x < running_max_speed :
			velocity.x += running_accel
		else :
			velocity.x = running_max_speed
	analyse_state()
	update_cd_ui()
	manage_animations()
	move_and_slide()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack") && can_attack():
		attack()
	if Input.is_action_just_pressed("move_up") && can_jump():
		jump()
	if Input.is_action_just_pressed("swap") && can_swap():
		swap()

func update_cd_ui() -> void:
	if !attack_cooldown_timer.is_stopped() :
		if !%AttackCDUi.visible :
			%AttackCDUi.visible = true
		%AttackCDUi.value = attack_cooldown_timer.time_left / attack_cd
	else :
		if %AttackCDUi.visible :
			%AttackCDUi.visible = false
	
	if !jump_cooldown_timer.is_stopped() :
		if !%JumpCDUi.visible :
			%JumpCDUi.visible = true
		%JumpCDUi.value =  jump_cooldown_timer.time_left / jump_cd
	else :
		if %JumpCDUi.visible :
			%JumpCDUi.visible = false
	
	if !swap_cooldown_timer.is_stopped() :
		if !%SwapCDUi.visible :
			%SwapCDUi.visible = true
		%SwapCDUi.value = swap_cooldown_timer.time_left /swap_cd
	else :
		if %SwapCDUi.visible :
			%SwapCDUi.visible = false
	pass

func analyse_state() -> void :
	if current_state != player_state.WALK and current_state != player_state.ATTACK && velocity.y == 0 :
		current_state = player_state.WALK

func jump() -> void:
	print_debug("jump!")
	current_state = player_state.JUMP
	if !is_in_mirror :
		velocity.y = -jump_velocity
	else : 
		velocity.y = +jump_velocity
	jump_cooldown_timer.start(jump_cd)

func can_jump() -> bool :
	if !jump_cooldown_timer.is_stopped() || ((!is_on_floor() && !is_in_mirror)||(!is_on_ceiling() && is_in_mirror)):
		return false
	return true

func swap() -> void:
	print_debug("swap!")
	swap_cooldown_timer.start(swap_cd )
	is_in_mirror = !is_in_mirror
	velocity *= 1.1
	%PlayerAnim.flip_v = is_in_mirror
	position.y = %SwapAxis.position.y - (position.y - %SwapAxis.position.y) 
	pass

func can_swap() -> bool:
	if !swap_cooldown_timer.is_stopped() :
		return false
	return true

func attack() -> void:
	print_debug("attack!")
	current_state = player_state.ATTACK
	attack_cooldown_timer.start(attack_cd)
	attack_state_timer.start(attack_duration)
	pass

func can_attack() -> bool:
	if !attack_cooldown_timer.is_stopped() :
		return false
	return true

func end_attack() -> void:
	current_state = player_state.WALK

func manage_animations() -> void :
	if str(current_state) != %PlayerAnim.animation :
		print_debug(str(current_state))
		%PlayerAnim.play(str(current_state))
