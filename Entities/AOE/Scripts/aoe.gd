class_name AOE extends Node2D

@onready var hitbox: Hitbox = $Hitbox
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var player: Player = MainInstance.player


func _ready() -> void:
	if animated_sprite.animation_finished.is_connected(_on_aoe_finished):
		animated_sprite.animation_finished.disconnect(_on_aoe_finished)
	
	animated_sprite.animation_finished.connect(_on_aoe_finished)


func _process(_delta: float) -> void:
	if player:
		hitbox.knockback = (player.facing_direction * hitbox.knockback_amount) * -1 


func _on_aoe_finished() -> void:
	call_deferred("queue_free")