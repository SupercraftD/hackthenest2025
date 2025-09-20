class_name Projectile extends CharacterBody2D

@export var SPEED = 800
@export var dmg = 10

var shooter

func _physics_process(delta: float) -> void:
	
	velocity = Vector2(SPEED,0).rotated(global_rotation)
	var slide = move_and_slide()

	if slide:
		
		var onlyCollidingWithParent = true
		for i in range(get_slide_collision_count()):
			if get_slide_collision(i).get_collider() != shooter:
				onlyCollidingWithParent = false
		
		if onlyCollidingWithParent:
			return
		
		
		queue_free()
		
		
	
	
