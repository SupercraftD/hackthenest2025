extends CharacterBody2D

@onready var roll = $Roll
@export var cursorProj : PackedScene

var inDialogue = false
var interacting = []

@onready var dustParticles = $dust
var speed = 150

var canShoot = true

func _ready():
	pass

func promptDialogue(tree):
	inDialogue = true
	await $CanvasLayer/dialoguepopup.showDialogue(tree)
	inDialogue = false

func _physics_process(delta):
	
	move()
	
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
	
	if Input.is_action_just_pressed("roll"):
		roll.startRoll(2)
	
	if abs(velocity.x) > 0.1:
		dustParticles.emitting = true
		dustParticles.position.x = -16 * sign(velocity.x)
	
	velocity = Input.get_vector("left","right","up","down") * speed
	move_and_slide()


func interact():
	if inDialogue:
		return
	
	for i in interacting:
		i.interact(self)


func shoot():
	if canShoot:
		canShoot = false
		
		var p = cursorProj.instantiate()
		p.global_position = global_position
		p.look_at(get_global_mouse_position())
		p.shooter = self
		get_parent().add_child(p)
		
		await p.done
		canShoot = true
