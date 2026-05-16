extends Node2D
class_name AnimationManager

var state_machine_to_manage : PlayerCharacter.player_state

func _physics_process(_delta: float) -> void:
	if state_machine_to_manage == null :
		state_machine_to_manage = (get_tree().root.get_child(0) as PlayerCharacter).current_state
	if str(state_machine_to_manage) != %PlayerAnim.animation :
		%PlayerAnim.play(str(state_machine_to_manage))
