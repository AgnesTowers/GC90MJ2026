extends Node2D
class_name AnimationManager

@onready var state_machine_to_manage : PlayerCharacter.player_state = (get_tree().get_root().get_node("PlayerCharacter") as PlayerCharacter).current_state

func _physics_process(_delta: float) -> void:
	if state_machine_to_manage == null :
		state_machine_to_manage = (get_tree().get_root().get_node("PlayerCharacter") as PlayerCharacter).current_state
		print_debug(str((get_tree().get_root().get_node("PlayerCharacter") as PlayerCharacter).current_state))
	if str(state_machine_to_manage) != %PlayerAnim.animation :
		print_debug(str(state_machine_to_manage))
		%PlayerAnim.play(str(state_machine_to_manage))
