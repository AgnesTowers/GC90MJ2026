extends ColorRect

@export var target: Node2D
@export var offset: Vector2i = Vector2i(-100, 0)

func _ready() -> void:
	var level: Level = find_parent("Level?")
	level.level_ending.connect(shatter)
	$AnimationPlayer.animation_finished.connect(func(anim_name: String) -> void:
		$AnimationPlayer.play("RESET")
		level.reset.emit()
		)
	material.set_shader_parameter("break_progress", 0.0)

func _process(delta: float) -> void:
	global_position.x = target.global_position.x + offset.x

func shatter() -> void:
	$AnimationPlayer.play("shatter")
	pass
