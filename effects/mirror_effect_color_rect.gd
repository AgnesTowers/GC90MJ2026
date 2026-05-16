extends ColorRect

@export var target: Node2D

func _process(delta: float) -> void:
	global_position.x = target.global_position.x
