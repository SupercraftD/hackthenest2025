extends CharacterBody2D

signal done

@export var SPEED = 800
@export var dmg = 1

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
			var c = get_slide_collision(i).get_collider()
			if c != shooter:
				onlyCollidingWithParent = false
				
				if c.has_method("hurt"):
					c.hurt(dmg, self)
					explode()
					return

		if onlyCollidingWithParent:
			return
		
		explode()
		
		
func explode():
	$acid.play("explode")
	await $acid.animation_finished
	emit_signal("done")
	queue_free()
	
