extends CharacterBody2D

@onready var roll = $Roll
@onready var hpbar = $CanvasLayer/hpbar

@export var weaponProjectiles = {
	"mouse":preload("res://projectiles/cursorprojectile.tscn")
}


var dead = false
var rollSpeed = 200
var rollVector = Vector2()

var hp = GameInfo.playerHp

var stam = 100

var inDialogue = false
var interacting = []

@onready var dustParticles = $dust
var speed = 150

var canShoot = true
var isRolling = false

var canHurt = true

func _ready():
	$flamegeyser/flamegeyser.playerSpawned = true
	hpbar.max_value = hp
	hpbar.value = hp

func promptDialogue(tree):
	inDialogue = true
	await $CanvasLayer/dialoguepopup.showDialogue(tree)
	inDialogue = false

func _physics_process(delta):
	hpbar.value = hp
	move()
	
	if hp <= 0:
		die()
	
	if stam < 100:
		stam += 1
	
	$CanvasLayer/stambar.value = stam
	
	if not isRolling:
		if (velocity == Vector2.ZERO):
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("run")
	
	if len(interacting)>0 and not inDialogue:
		$CanvasLayer/interactlabel.visible = true
	else:
		$CanvasLayer/interactlabel.visible = false
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	if Input.is_action_just_pressed("special") and "flamethrower" in GameInfo.availableWeapons:
		special()
	
	if Input.is_action_just_pressed("interact"):
		interact()
	

var canSpecial = true
func special():
	
	if canSpecial:
		canSpecial = false
		$flamegeyser.visible = true
		$flamegeyser.look_at(get_global_mouse_position())
		await $flamegeyser/flamegeyser.start()
		$flamegeyser.visible = false
		await get_tree().create_timer(1).timeout
		canSpecial = true

func move():
	if inDialogue or dead:
		return
	
	if Input.is_action_just_pressed("roll") and not isRolling and stam>=100:
		stam = 0
		isRolling = true
		rollVector = velocity.normalized()* rollSpeed
		$AnimatedSprite2D.play("roll")
		roll.startRoll(.4)
		await roll.rollDone
		isRolling = false
		rollVector = Vector2()
	
	if abs(velocity.x) > 0.1:
		dustParticles.emitting = true
		dustParticles.position.x = -16 * sign(velocity.x)
	
	velocity = Input.get_vector("left","right","up","down") * speed
	velocity += rollVector
	move_and_slide()


func interact():
	if inDialogue:
		return
	
	for i in interacting:
		i.interact(self)


func shoot():
	
	if inDialogue or GameInfo.weapon == -1:
		return
	
	
	var proj = weaponProjectiles["mouse"]
	
	if canShoot and not isRolling:
		canShoot = false
		
		var p = proj.instantiate()
		
		p.global_position = global_position
		p.look_at(get_global_mouse_position())
		
		p.shooter = self
		get_parent().add_child(p)
		
		#$Camera2D.start_shake(8.0, 0.5)
		
		await p.done
		canShoot = true

func hurt(dmg, atk):

	if canHurt and not isRolling and atk != $flamegeyser/flamegeyser:
		hp -= dmg
		$Camera2D.start_shake(2.0, 0.3)
		canHurt = false
		await get_tree().create_timer(0.5).timeout
		canHurt = true

func die():
	dead = true
	create_tween().tween_property(self,"modulate",Color(0,0,0),1)
	await create_tween().tween_property(self, "rotation_degrees",90,1).finished
	
	get_tree().reload_current_scene()
