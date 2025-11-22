extends Node

@warning_ignore("unused_signal")
signal request_camera_target(new_target: RemoteTransform2D)

@warning_ignore("unused_signal")
signal request_camera_limits(camera_limits: CameraLimits)

@warning_ignore("unused_signal")
signal request_camera_screenshake(amount: float, duration: float)

@warning_ignore("unused_signal")
signal door_entered(door: Door)

@warning_ignore("unused_signal")
signal equipment_changed(item: Item)