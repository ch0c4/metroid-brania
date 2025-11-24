class_name LaboController extends Node

const ROCK_SPIKE_AOE: PackedScene = preload("res://Entities/AOE/RockSpike/rock_spike_aoe.tscn")

@onready var player: Player = MainInstance.player


func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	var aoe: AOE = ROCK_SPIKE_AOE.instantiate()
	aoe.global_position = player.global_position
	get_tree().current_scene.add_child(aoe)
