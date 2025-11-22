extends State

@export var animation_player: AnimationPlayer

@onready var skeleton: Skeleton = get_owner()


func enter() -> void:
	if !animation_player.animation_finished.is_connected(_on_death_animation_finished):
		animation_player.animation_finished.connect(_on_death_animation_finished)
	
	animation_player.play("death")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	skeleton.velocity = Vector2.ZERO


func _on_death_animation_finished(_anim_name: StringName) -> void:
	skeleton.call_deferred("queue_free")