@abstract
class_name State extends Node

@warning_ignore("unused_signal")
signal transitionned(state: State, new_state: String)

@abstract func enter() -> void

@abstract func exit() -> void

@abstract func update(delta: float) -> void

@abstract func physics_update(delta: float) -> void
