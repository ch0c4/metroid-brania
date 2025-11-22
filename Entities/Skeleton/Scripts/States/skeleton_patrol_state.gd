extends State

@export var animation_player: AnimationPlayer
@export var navigation_agent: NavigationAgent2D

@onready var skeleton: Skeleton = get_owner()


func enter() -> void:	
	animation_player.play("walk")
	var target_position := NavigationServer2D.map_get_random_point(navigation_agent.get_navigation_map(), navigation_agent.navigation_layers, false)
	navigation_agent.target_position = target_position
	if !navigation_agent.target_reached.is_connected(_on_target_reached):
		navigation_agent.target_reached.connect(_on_target_reached)


func exit() -> void:
	if navigation_agent.target_reached.is_connected(_on_target_reached):
		navigation_agent.target_reached.disconnect(_on_target_reached)


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	var target_position := navigation_agent.get_next_path_position()
	var target_direction := skeleton.global_position.direction_to(target_position)
	skeleton.facing_direction = target_direction
	
	CharacterMover.accelerate_in_direction(skeleton, target_direction, skeleton.patrol_movement_stats, delta)
	CharacterMover.move_and_bounce(skeleton, delta)


func _on_target_reached() -> void:
	transitionned.emit(self, "Waiting")