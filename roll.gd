extends Node2D

@onready var durationTimer = $durationTimer
var canDash = true

func startDash(duration):
	durationTimer.wait_time = duration
	durationTimer.start()
	
func isDashing():
	return !durationTimer.is_stopped()
	
func endDash():
	canDash = false
	await get_tree().create_timer(3).timeout
	canDash = true
