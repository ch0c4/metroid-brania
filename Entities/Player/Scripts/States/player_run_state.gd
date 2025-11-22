extends State


@export var animation_player: AnimationPlayer


@onready var player: Player = get_owner()


func enter() -> void:
	animation_player.play("run")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

	if !Input.is_action_pressed("sprint"):
		transitionned.emit(self, "Idle" if input_vector == Vector2.ZERO else "Walking")
	else:
		CharacterMover.accelerate_in_direction(player, input_vector, player.sprint_movement_stats, delta)
		CharacterMover.move(player)