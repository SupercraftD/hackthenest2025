extends CharacterBody2D
var secondPhase = false
@onready var undamaged = $undamgedLasers
@onready var damaged = $damagedLasers
@onready var timer = $Timer
var isAttacking = false

func _process(delta: float) -> void:
	if !isAttacking:
		$AnimatedSprite2D.play("default")

func laserEyes():
	if !secondPhase:
		undamaged.shoot()
	
	await damaged.shoot()


func _on_timer_timeout() -> void:
	isAttacking = true
	await laserEyes()
	timer.start()
