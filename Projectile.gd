class_name Projectile extends CharacterBody2D

signal done

@export var SPEED = 800
@export var dmg = 10

var shooter

func _ready():
	await get_tree().create_timer(3).timeout
	emit_signal("done")
	queue_free()

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
		
		emit_signal("done")
		queue_free()
		
		
	
	
