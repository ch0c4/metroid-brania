class_name Skeleton extends CharacterBody2D

@export var patrol_movement_stats: MovementStats
@export var chase_movement_stats: MovementStats
@export var stats: Stats

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var body_hitbox: Hitbox = $BodyHitbox
@onready var player_detector: Area2D = $PlayerDetector
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
		
		body_hitbox.knockback = value * body_hitbox.knockback_amount
		facing_direction = value


func _ready() -> void:
	if player_detector.body_entered.is_connected(_on_body_entered):
		player_detector.body_entered.disconnect(_on_body_entered)
	
	if hurtbox.hurt.is_connected(_on_hurt):
		hurtbox.hurt.disconnect(_on_hurt)
	
	player_detector.body_entered.connect(_on_body_entered)
	hurtbox.hurt.connect(_on_hurt)


func _on_hurt(hitbox: Hitbox) -> void:
	if hitbox is Hitbox:
		other_hitbox = hitbox
		state_machine.force_child_transition("Hurt")


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		state_machine.force_child_transition("Chase")
		