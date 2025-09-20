extends CharacterBody2D

@onready var hurtBox = $hurtBox
@onready var player = $Player
@onready var sight : Area2D = $Sight

var hp = 3

var speed: float = 50.0
var wander_direction: Vector2 = Vector2.ZERO
var wander_timer: float = 0.0
var wander_interval: float = 2.0 # seconds before picking a new random direction

func _physics_process(delta: float) -> void:
	var target_velocity = Vector2.ZERO

	if is_player_in_sight():
		# Chase the player
		var direction = (player.global_position - global_position).normalized()
		target_velocity = direction * speed
	else:
		# Wander randomly
		wander_timer -= delta
		if wander_timer <= 0.0:
			wander_direction = Vector2(randf() * 2.0 - 1.0, randf() * 2.0 - 1.0).normalized()
			wander_timer = wander_interval
		target_velocity = wander_direction * (speed * 0.5) # slower wandering

	velocity = target_velocity
	var col = move_and_collide(velocity * delta)

	if col:
		var c = col.get_collider()
		if c.is_in_group("player"):
			c.hurt(3,self)

	# Make the enemy face the movement direction
	if velocity.length() > 1.0:
		rotation = velocity.angle()
	
	if hp <= 0:
		die()

func die():
	queue_free()

func hurt(dmg, atk):
	hp -= dmg
	

func is_player_in_sight() -> bool:
	for i in sight.get_overlapping_bodies():
		if i.is_in_group("player"):
			player = i
			return true
	return false
