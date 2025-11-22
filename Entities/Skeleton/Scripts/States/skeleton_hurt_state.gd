extends State

@export var animation_player: AnimationPlayer

@onready var skeleton: Skeleton = get_owner()

var animation_finished := false

func enter() -> void:
	skeleton.stats.health -= skeleton.other_hitbox.damage
	
	if !animation_player.animation_finished.is_connected(_on_hurt_animation_finished):
		animation_player.animation_finished.connect(_on_hurt_animation_finished)
	
	animation_finished = false

	animation_player.play("hurt")
	CharacterMover.apply_knockback(skeleton, skeleton.other_hitbox.knockback)


func exit() -> void:
	if animation_player.animation_finished.is_connected(_on_hurt_animation_finished):
		animation_player.animation_finished.disconnect(_on_hurt_animation_finished)


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	CharacterMover.decelerate(skeleton, skeleton.chase_movement_stats, delta)
	CharacterMover.move_and_bounce(skeleton, delta)
	
	if skeleton.velocity.is_equal_approx(Vector2.ZERO) and !skeleton.stats.is_health_gone() and animation_finished:
		transitionned.emit(self, "Chase")


func _on_hurt_animation_finished(_anim_name: StringName) -> void:
	animation_finished = true
	if skeleton.stats.is_health_gone():
		transitionned.emit(self, "Death")