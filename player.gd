extends CharacterBody2D

var speed = 400

func _physics_process(delta):
	
	velocity = Input.get_vector("left","right","up","down") * speed
	
	move_and_slide()
	
	
