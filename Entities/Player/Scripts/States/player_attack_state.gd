extends State


@export var animation_player: AnimationPlayer
@export var hitbox: Hitbox

@onready var player: Player = get_owner()

var attack_direction: Vector2 = Vector2.ZERO


func enter() -> void:
	if !animation_player.animation_finished.is_connected(_on_animation_finished):
		animation_player.animation_finished.connect(_on_animation_finished)	
	animation_player.play("attack")
	
	hitbox.knockback = player.facing_direction * hitbox.knockback_amount
	


func exit() -> void:
	if animation_player.animation_finished.is_connected(_on_animation_finished):
		animation_player.animation_finished.disconnect(_on_animation_finished)


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	CharacterMover.decelerate(player, player.movement_stats, delta)
	CharacterMover.move(player)


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		var sprinting: bool = Input.is_action_pressed("sprint")

		if input_vector == Vector2.ZERO:
			transitionned.emit(self, "Idle")
		elif sprinting:
			transitionned.emit(self, "Run")
		else:
			transitionned.emit(self, "Walking")
