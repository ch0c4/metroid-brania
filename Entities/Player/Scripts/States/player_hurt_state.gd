extends State


@export var animation_player: AnimationPlayer
@export var hurtbox: Hurtbox

@onready var player: Player = get_owner()


func enter() -> void:
	hurtbox.is_invincible = true
	if !animation_player.animation_finished.is_connected(_on_animation_hurt_finished):
		animation_player.animation_finished.connect(_on_animation_hurt_finished)
	animation_player.play("hurt")
	
	CharacterMover.apply_knockback(player, player.other_hitbox.knockback)


func exit() -> void:
	if animation_player.animation_finished.is_connected(_on_animation_hurt_finished):
		animation_player.animation_finished.disconnect(_on_animation_hurt_finished)
	hurtbox.is_invincible = false


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	CharacterMover.decelerate(player, player.movement_stats, delta)
	CharacterMover.move_and_bounce(player, delta)


func _on_animation_hurt_finished(_anim_name: StringName) -> void:
	transitionned.emit(self, "Idle")
