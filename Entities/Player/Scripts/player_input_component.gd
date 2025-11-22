extends Node

@export var state_machine: StateMachine
@export var interaction_detector: PlayerInteractionDetector

var equipment: Item: set = _set_equipment

func _set_equipment(value: Item) -> void:
	equipment = value


func _ready() -> void:
	Events.equipment_changed.connect(_set_equipment)


func _physics_process(_delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

	var sprinting: bool = Input.is_action_pressed("sprint")
	var rolling: bool = Input.is_action_just_pressed("roll")
	var attacking: bool = Input.is_action_just_pressed("action")
	var interact: bool = Input.is_action_just_pressed("interact")
	
	if interact and interaction_detector.can_interact():
		interaction_detector.trigger_interaction()
	
	if rolling:
		state_machine.force_child_transition("Roll")
		return
	
	if attacking:
		_trigger_action_state()
		return
	
	if sprinting and input_vector != Vector2.ZERO:
		state_machine.force_child_transition("Run")
		return


func _trigger_action_state() -> void:
	if not equipment:
		state_machine.force_child_transition("Attack")
		return
	
	match equipment.name.to_lower():
		"sword":
			state_machine.force_child_transition("Attack")
		"axe":
			state_machine.force_child_transition("Chop")
		"pickaxe":
			state_machine.force_child_transition("Mine")
		"shovel":
			state_machine.force_child_transition("Dig")
	
