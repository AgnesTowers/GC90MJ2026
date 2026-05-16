extends Node2D
class_name GravityManager

var body_to_affect : CharacterBody2D
@export var gravity_strength : float = 5 * 9.81

func _ready() -> void:
	body_to_affect = get_parent()

func _physics_process(delta: float) -> void:
	apply_gravity(delta)

func apply_gravity(delta: float) -> void:
	if !body_to_affect.is_on_floor() :
		if body_to_affect is PlayerCharacter :
			if !body_to_affect.is_in_mirror : 
				body_to_affect.velocity.y += gravity_strength*delta
			else :
				body_to_affect.y -= gravity_strength *delta
		else :
			body_to_affect.velocity.y -= gravity_strength *delta
