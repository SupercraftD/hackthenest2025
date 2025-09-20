extends CharacterBody2D

@onready var bar = $CanvasLayer/TextureProgressBar
var hp = 100
var maxhp = hp

signal dead


@export var fireballProj : PackedScene
@export var geyser : PackedScene
@onready var player = get_parent().get_node("Player")
var done = false
var speed = 50
var started = false
func start():
	$CanvasLayer/TextureProgressBar.visible = true
	bar.max_value = maxhp
	bar.value = hp
	started = true
	$Fireballtimer.start()
	$Fireballtimer.timeout.connect(shootFireball)
	$firearraytimer.timeout.connect(fireballArray)
	
	$geysertimer.timeout.connect(spawnGeyser)


func _physics_process(delta: float) -> void:
	bar.value = hp
	if not started or done:
		return
	
	velocity = Vector2(speed,0)
	speed+=0.01
	
	var col = move_and_collide(velocity * delta)

	if col:
		var c = col.get_collider()
		if c.is_in_group("player"):
			c.hurt(1000,self)
	
	if hp < 0.75*maxhp and $firearraytimer.is_stopped():
		$firearraytimer.start()
	
	if hp < 0.5*maxhp and $geysertimer.is_stopped():
		$geysertimer.start()
	print(hp," ",done)
	if hp <= 0 and not done:
		print("rahh")
		die()

func die():
	done = true
	emit_signal("dead")
	await player.promptDialogue(["[b]Firewall: [/b]You may have overridden the firewall... but you'll never get past the DNS!"])
	queue_free()

func hurt(dmg, atk):
	hp -= dmg

func shootFireball():
	if done:return
	var spot = $firevalves/Marker2D
	for i in $firevalves.get_children():
		if i.global_position.distance_to(player.global_position) < spot.global_position.distance_to(player.global_position):
			spot = i
	
	var angle = (player.global_position - spot.global_position).angle()

	var fb = fireballProj.instantiate()
	
	fb.global_position = spot.global_position
	fb.global_rotation = angle
	
	fb.shooter = self
	
	get_parent().add_child(fb)
	$Fireballtimer.wait_time -= 0.01

func fireballArray():
	if done:return
	var s = -60
	var e = 60
	for a in range(s,e,(e-s)/8.0):
		if done:return
		var proj = fireballProj.instantiate()
		proj.global_position = $firevalves/Marker2D2.global_position
		proj.global_rotation_degrees = a
		
		proj.shooter = self
		get_parent().add_child(proj)
		await get_tree().create_timer(0.15).timeout

func spawnGeyser():
	if done:return
	var spot = $top
	if player.global_position.y > $firevalves/Marker2D2.global_position.y:
		spot = $bottom
	
	var g = geyser.instantiate()
	g.global_position = Vector2(player.global_position.x+randi_range(-50,50),spot.global_position.y)
	if spot == $bottom:
		g.global_rotation_degrees = 180
	get_parent().geysers.append(g)
	get_parent().add_child(g)
