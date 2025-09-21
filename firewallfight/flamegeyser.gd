extends Area2D

@export var playerSpawned = false

func _ready():
	if not playerSpawned:
		start()

func start():
	$AnimatedSprite2D.play("priming")
	await $AnimatedSprite2D.animation_finished
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.play("burn")
	await get_tree().create_timer(1).timeout
	$CollisionShape2D.disabled = true
	

func _physics_process(delta: float) -> void:
	for i in get_overlapping_bodies():
		if not playerSpawned:
			if i.is_in_group("player"):
				i.hurt(2,self)
		else:
			if i.has_method("hurt"):
				i.hurt(1,self)
