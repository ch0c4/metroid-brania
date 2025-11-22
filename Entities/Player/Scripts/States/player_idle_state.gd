extends State


@export var animation_player: AnimationPlayer


@onready var player: Player = get_owner()


func enter() -> void:
	animation_player.play("idle")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

	if (input_vector != Vector2.ZERO):
		transitionned.emit(self, "Walking")
	else:
		CharacterMover.decelerate(player, player.movement_stats, delta)
		CharacterMover.move(player)