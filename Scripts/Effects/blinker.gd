class_name Blinker extends Effector


func blink(duration := 1.0, blinks := 8) -> void:
	if target is not CanvasItem:
		push_error("The target on your blinker isn't set")
		return
	
	var blink_duration := duration / blinks
	for i in blinks:
		if !is_instance_valid(target):
			return
		target.visible = !target.visible
		await target.get_tree().create_timer(blink_duration).timeout
	
	if !is_instance_valid(target):
		return
	
	target.visible = true
		
