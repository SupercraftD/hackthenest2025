extends Area2D

func _ready():
	$AnimatedSprite2D.play("priming")
	await $AnimatedSprite2D.animation_finished
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.play("burn")

func _physics_process(delta: float) -> void:
	for i in get_overlapping_bodies():
		if i.is_in_group("player"):
			i.hurt(2,self)
