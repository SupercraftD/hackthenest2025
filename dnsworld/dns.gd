extends CharacterBody2D


var hp = 100
var maxhp = hp
var secondPhase = false

@onready var undamaged = $undamgedLasers
@onready var damaged = $damagedLasers
@onready var timer = $Timer
@onready var bar = $CanvasLayer/TextureProgressBar

@onready var player = get_parent().get_node("Player")

var isAttacking = false

var stickman = preload("res://dnsworld/stickman.tscn")
var worm = preload("res://dnsworld/worm.tscn")


var isDead = false
func start():
	bar.visible = true
	bar.max_value = hp
	bar.value = hp
	$Timer.start()
	$spawntimer.start()
	


func _physics_process(delta: float) -> void:
	if isDead:
		return
	if !isAttacking:
		$AnimatedSprite2D.play("default")
	
	for lasers in [$undamgedLasers, $damagedLasers]:
		for pivot in lasers.get_children():
			for b in pivot.get_node("laser/Area2D").get_overlapping_bodies():
				if b.is_in_group("player"):
					b.hurt(2,pivot)
	for b in $bellyLaser.get_overlapping_bodies():
		if b.is_in_group("player"):
			b.hurt(4,$bellyLaser)
	
	if hp < 0.5 * maxhp:
		secondPhase = true
	
	bar.value = hp
	if hp<=0:
		die()

var canDmg = true
func hurt(dmg, atk):
	if canDmg:
		hp -= dmg
		canDmg = false
		await get_tree().create_timer(0.1).timeout
		canDmg = true

func die():
	isDead=true
	player.invuln = true
	create_tween().tween_property(self,"modulate",Color(0,0,0),1).finished
	await player.promptDialogue([
		"[b]DNS: [/b]fine... have it your way. Go ahead and access that link."
	])
	await create_tween().tween_property(get_parent().get_node("CanvasLayer/Panel"),"modulate:a",1,1).finished
	get_tree().change_scene_to_file("res://cutscenes/closing.tscn")
	queue_free()

func laserEyes():
	if isDead:return
	if !secondPhase:
		undamaged.shoot()
	
	await damaged.shoot()

func _on_timer_timeout() -> void:
	isAttacking = true
	if isDead:return
	if randi_range(0,1)==0 or not secondPhase:
		await laserEyes()
	else:
		await bellyLaser()
	timer.start()

func bellyLaser():
	if isDead:return
	$AnimatedSprite2D.play("bellyLaser")
	await $AnimatedSprite2D.animation_finished
	$bellyLaser.look_at(player.global_position)
	$bellyLaser.modulate.a = 0.5
	await get_tree().create_timer(1).timeout
	$bellyLaser.modulate.a = 1
	player.get_node("Camera2D").start_shake(4.0, 0.3)

	$bellyLaser/CollisionShape2D.disabled = false
	await get_tree().create_timer(3).timeout
	$bellyLaser.modulate.a = 0
	$bellyLaser/CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("default")

var spawnAmount = 2
func _on_spawntimer_timeout() -> void:
	if isDead:return
	for i in range(spawnAmount):
		var e = [stickman, worm].pick_random().instantiate()
		
		e.global_position = global_position + Vector2(0,100)#*(i+1))
		get_parent().add_child(e)
	
	spawnAmount+=1
