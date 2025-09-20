extends Node2D

@onready var durationTimer = $durationTimer
var canRoll = true

func startRoll(duration):
	durationTimer.wait_time = duration
	durationTimer.start()
	
func isRolling():
	return !durationTimer.is_stopped()
	
func endRoll():
	canRoll = false
	await get_tree().create_timer(3).timeout
	canRoll = true
