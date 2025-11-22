extends State


@export var animation_player: AnimationPlayer

@onready var player: Player = get_owner()

var chop_direction: Vector2 = Vector2.ZERO
var is_holding := false


func enter() -> void:
	player.velocity = Vector2.ZERO
	is_holding = Input.is_action_pressed("action")
	chop_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if chop_direction == Vector2.ZERO:
		chop_direction = Vector2.LEFT if player.scale.y < 0.0 else Vector2.RIGHT
	
	animation_player.play("axe")
	
	if !animation_player.animation_finished.is_connected(_on_animation_finished):
		animation_player.animation_finished.connect(_on_animation_finished)


func exit() -> void:
	if animation_player.animation_finished.is_connected(_on_animation_finished):
		animation_player.animation_finished.disconnect(_on_animation_finished)


func update(_delta: float) -> void:
	is_holding = Input.is_action_pressed("action")


func physics_update(delta: float) -> void:
	CharacterMover.decelerate(player, player.movement_stats, delta)
	CharacterMover.move(player)


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name != "axe":
		return
	
	if is_holding:
		animation_player.play("axe")
		return

	if anim_name == "axe":
		var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		var sprinting: bool = Input.is_action_pressed("sprint")

		if input_vector == Vector2.ZERO:
			transitionned.emit(self, "Idle")
		elif sprinting:
			transitionned.emit(self, "Run")
		else:
			transitionned.emit(self, "Walking")
