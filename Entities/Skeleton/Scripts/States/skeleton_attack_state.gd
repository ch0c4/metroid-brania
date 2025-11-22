extends State

@export var animation_player: AnimationPlayer
@export var hitbox: Hitbox

@onready var skeleton: Skeleton = get_owner()


func enter() -> void:
	if !animation_player.animation_finished.is_connected(_on_attack_animation_finished):
		animation_player.animation_finished.connect(_on_attack_animation_finished)
	
	animation_player.play("attack")
	hitbox.knockback = skeleton.facing_direction * hitbox.knockback_amount
	hitbox.damage = 1.0


func exit() -> void:
	if animation_player.animation_finished.is_connected(_on_attack_animation_finished):
		animation_player.animation_finished.disconnect(_on_attack_animation_finished)


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	CharacterMover.decelerate(skeleton, skeleton.chase_movement_stats, delta)
	CharacterMover.move(skeleton)


func _on_attack_animation_finished(_anim_name: StringName) -> void:
	transitionned.emit(self, "Chase")
