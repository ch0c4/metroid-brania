class_name FlipComponent extends Node

@export var anchor: Node2D

var character: CharacterBody2D


func _ready() -> void:
	
	if anchor is CharacterBody2D:
		character = anchor
	
	if anchor.get_parent() is CharacterBody2D:
		character = anchor.get_parent()


func _process(_delta: float) -> void:
	if not anchor:
		return
	
	if not character:
		return
	
	if character.velocity.x > 0.0:
		anchor.scale.x = anchor.scale.y * 1
	
	if character.velocity.x < 0.0:
		anchor.scale.x = anchor.scale.y * -1

