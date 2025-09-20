extends CharacterBody2D

@onready var roll = $Roll
@export var cursorProj : PackedScene

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
	
	
	
	if Input.is_action_just_pressed("shoot"):
		shoot()


func shoot():
	var p = cursorProj.instantiate()
	p.global_position = global_position
	p.look_at(get_global_mouse_position())
	p.shooter = self
	get_parent().add_child(p)
