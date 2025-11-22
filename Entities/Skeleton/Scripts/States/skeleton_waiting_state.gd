extends State

@export var animation_player: AnimationPlayer


func enter() -> void:
	animation_player.play("idle")
	await get_tree().create_timer(1.0).timeout
	transitionned.emit(self, "Patrol")


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass
