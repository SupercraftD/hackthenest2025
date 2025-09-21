extends Camera2D

var shake_amplitude = 0.0
var shake_timer = 0.0
var shake_duration = 0.0

func _process(delta):
	if shake_timer > 0:
		shake_timer -= delta

		# Optional: fade out shake
		var fade = shake_timer / shake_duration
		var current_amplitude = shake_amplitude * fade

		offset = Vector2(
			randf_range(-current_amplitude, current_amplitude),
			randf_range(-current_amplitude, current_amplitude)
		)
	else:
		offset = Vector2.ZERO

func start_shake(amplitude: float, duration: float) -> void:
	# Always reset the state
	shake_amplitude = amplitude
	shake_duration = duration
	shake_timer = duration
