extends ColorRect

@export var target: Node2D
@export var offset: Vector2i = Vector2i(-100, 0)

func _process(delta: float) -> void:
	global_position.x = target.global_position.x + offset.x
