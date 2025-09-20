extends Node2D

signal rollDone

@onready var durationTimer = $durationTimer

func startRoll(duration):
	durationTimer.wait_time = duration
	durationTimer.start()

func isRolling():
	return !durationTimer.is_stopped()
	
func endRoll():
	emit_signal("rollDone")
	await get_tree().create_timer(2).timeout
