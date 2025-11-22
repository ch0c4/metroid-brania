extends State

@export var animation_player: AnimationPlayer

@onready var skeleton: Skeleton = get_owner()
@onready var player: Player = MainInstance.player

var range_distance := 45.0


func enter() -> void:
	animation_player.play("walk")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	var target_direction := skeleton.global_position.direction_to(player.global_position)
	skeleton.facing_direction = target_direction
	
	if skeleton.global_position.distance_to(player.global_position) < 20.0:
		transitionned.emit(self, "Attack")
	
	CharacterMover.accelerate_in_direction(skeleton, target_direction, skeleton.chase_movement_stats, delta)
	CharacterMover.move_and_bounce(skeleton, delta)
