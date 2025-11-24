class_name Lifebar extends TextureProgressBar

@export var character: CharacterBody2D

func _ready() -> void:
	visible = false
	if character:
		_connect_to_player()


func _connect_to_player() -> void:
	if character == null:
		return
	
	if character.stats == null:
		push_warning("CharacterStats not found")
		return
	
	if character.stats.health_changed.is_connected(_on_player_health_changed):
		character.stats.health_changed.disconnect(_on_player_health_changed)
	
	if character.stats.max_health_changed.is_connected(_on_player_max_health_changed):
		character.stats.max_health_changed.disconnect(_on_player_max_health_changed)
	
	if character.stats.no_health.is_connected(_on_player_no_health):
		character.stats.no_health.disconnect(_on_player_no_health)
	
	character.stats.health_changed.connect(_on_player_health_changed)
	character.stats.max_health_changed.connect(_on_player_max_health_changed)
	character.stats.no_health.connect(_on_player_no_health)
	
	value = character.stats.health
	max_value = character.stats.max_health


func _on_player_health_changed(new_health: int) -> void:
	visible = true
	var tween := create_tween()
	tween.tween_property(self, "value", float(new_health), 0.25).set_trans(Tween.TRANS_SINE)
	await tween.finished
	await get_tree().create_timer(0.6).timeout
	visible = false


func _on_player_max_health_changed(new_max: int) -> void:
	max_value = new_max


func _on_player_no_health() -> void:
	visible = true
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	await tween.finished
	await get_tree().create_timer(0.6).timeout
	visible = false