class_name Player extends CharacterBody2D

@export var stats: Stats
@export var movement_stats: MovementStats
@export var sprint_movement_stats: MovementStats

@onready var remote_transform_2d: RemoteTransform2D = $RemoteCamera
@onready var lifebar: Lifebar = $Lifebar
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var state_machine: StateMachine = $StateMachine

var other_hitbox: Hitbox

var facing_direction := Vector2.RIGHT:
	set(value):
		if value == Vector2.ZERO:
			return
		value.normalized()
		
		if abs(value.x) >= abs(value.y) - 0.1:
			value = Vector2(sign(value.x), 0)
			
		else:
			value = Vector2(0, sin(value.y))
		
		facing_direction = value

func _enter_tree() -> void:
	MainInstance.player = self


func _exit_tree() -> void:
	MainInstance.player = null


func _ready() -> void:
	Events.request_camera_target.emit.call_deferred(remote_transform_2d)
	hurtbox.hurt.connect(_on_hurt)


func _on_hurt(hitbox: Hitbox) -> void:
	other_hitbox = hitbox
	state_machine.force_child_transition("Hurt")
	
	