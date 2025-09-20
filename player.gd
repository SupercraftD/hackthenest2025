extends CharacterBody2D

@onready var roll = $Roll
@onready var hpbar = $hpbar

@export var weaponProjectiles = {
	"mouse":preload("res://projectiles/cursorprojectile.tscn")
}

var rollSpeed = 200
var rollVector = Vector2()

var hp = 10

var stam = 100

var inDialogue = false
var interacting = []

@onready var dustParticles = $dust
var speed = 150

var canShoot = true
var isRolling = false

var canHurt = true

func _ready():
	hpbar.max_value = hp
	hpbar.value = hp

func promptDialogue(tree):
	inDialogue = true
	await $CanvasLayer/dialoguepopup.showDialogue(tree)
	inDialogue = false

func _physics_process(delta):
	hpbar.value = hp
	move()
	
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
	
	if Input.is_action_just_pressed("interact"):
		interact()

func move():
	if inDialogue:
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
	
	if GameInfo.weapon == -1:
		return
	
	var weapon = GameInfo.availableWeapons[GameInfo.weapon]
	
	var proj = weaponProjectiles[weapon]
	
	if canShoot and not isRolling:
		canShoot = false
		
		var p = proj.instantiate()
		
		p.global_position = global_position
		p.look_at(get_global_mouse_position())
		
		p.shooter = self
		get_parent().add_child(p)
		
		$Camera2D.start_shake(8.0, 0.5)
		
		await p.done
		canShoot = true

func hurt(dmg, atk):
	if canHurt and not isRolling:
		hp -= dmg
		canHurt = false
		await get_tree().create_timer(0.5).timeout
		canHurt = true
