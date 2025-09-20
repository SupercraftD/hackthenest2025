extends CharacterBody2D

@onready var roll = $Roll
var speed = 400

func _physics_process(delta):
	
	if Input.is_action_just_pressed("roll"):
		roll.startRoll(2)
	
	velocity = Input.get_vector("left","right","up","down") * speed
	move_and_slide()
	
	if (velocity == Vector2.ZERO):
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("run")
