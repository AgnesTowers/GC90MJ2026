extends CharacterBody2D
class_name PlayerCharacter

enum player_state{
	WALK,
	JUMP,
	ATTACK,
	DEAD
}


@export var jump_velocity : float
@export var running_speed : float
@export var jump_cd : float
@export var attack_cd : float
@export var swap_cd : float
@export var attack_duration : float

var current_state : player_state = player_state.WALK
var is_in_mirror : bool

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
	analyse_state()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack") && can_attack():
		attack()
	if Input.is_action_just_pressed("move_up") && can_jump():
		jump()
	if Input.is_action_just_pressed("swap") && can_swap():
		swap()


func analyse_state() -> void :
	if current_state != player_state.WALK or current_state != player_state.ATTACK && velocity.y == 0 :
		current_state = player_state.WALK

func jump() -> void:
	print_debug("jump!")
	current_state = player_state.JUMP
	velocity.y += jump_velocity
	jump_cooldown_timer.start(jump_cd)

func can_jump() -> bool :
	if !jump_cooldown_timer.is_stopped() || !is_on_floor():
		return false
	return true

func swap() -> void:
	print_debug("swap!")
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
