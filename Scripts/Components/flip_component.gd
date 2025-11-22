class_name FlipComponent extends Node

@export var character: CharacterBody2D


func _process(_delta: float) -> void:
	if not character:
		return
	
	if character.velocity.x > 0.0:
		character.scale.x = character.scale.y * 1
	
	if character.velocity.x < 0.0:
		character.scale.x = character.scale.y * -1

