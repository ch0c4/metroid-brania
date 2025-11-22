extends State


@export var animation_player: AnimationPlayer
@export var hurtbox: Hurtbox


@onready var player: Player = get_owner()


var roll_direction: Vector2 = Vector2.ZERO

func enter() -> void:
	roll_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	
	if roll_direction == Vector2.ZERO:
		roll_direction = Vector2.LEFT if player.scale.y < 0.0 else Vector2.RIGHT
	
	CharacterMover.apply_knockback(player, roll_direction * 200.0)
	
	animation_player.play("roll")

	animation_player.animation_finished.connect(_on_animation_finished)


func exit() -> void:
	animation_player.animation_finished.disconnect(_on_animation_finished)


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	if CharacterMover.move_and_bounce(player, delta):
		transitionned.emit(self, "Idle")


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "roll":

		var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
		var sprinting = Input.is_action_pressed("sprint")

		if input_vector == Vector2.ZERO:
			transitionned.emit(self, "Idle")

		elif sprinting:
			transitionned.emit(self, "Run")

		else:
			transitionned.emit(self, "Walking")