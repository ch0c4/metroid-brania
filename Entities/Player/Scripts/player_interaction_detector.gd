class_name PlayerInteractionDetector extends Area2D


func trigger_interaction() -> void:
	var interactions: Array[Area2D] = get_overlapping_areas()
	for interaction: Interaction in interactions:
		interaction.run()

func can_interact() -> bool:
	return !get_overlapping_areas().is_empty()
