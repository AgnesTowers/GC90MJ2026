extends Area2D
class_name DeathPlane

@export var player: PlayerCharacter
@export var follow_x: bool = false
@export var follow_y: bool = false

func _process(delta: float) -> void:
	if follow_x:
		global_position.x = player.global_position.x
	if follow_y:
		global_position.y = player.global_position.y

func _on_area_entered(area: Area2D) -> void:
	if area is DeathComponent:
		(area as DeathComponent).die.emit(self)
