extends Area2D
class_name DeathComponent

@export var target: Node

signal die

func _ready() -> void:
	
	if target == null:
		target = get_parent()
	
	die.connect(func(source: Node):
		call_deferred("_on_die", source)
		)

func _on_die(source: Node) -> void:
	var level: Level = find_parent("Level?")
	level.level_ending.emit()
