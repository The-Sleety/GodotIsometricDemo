extends CharacterBody2D

class_name Player

@export_category("Texts and onreadies")
@onready var healtText = $"../CanvasLayer/Healt"
@onready var cooldown_timer = $CooldownTimer
@onready var anim = $AnimationPlayer
@onready var player_sprite = $Sprite2D
@onready var speedText = $"../CanvasLayer/Speed"
@onready var deal_attack_timer = $DealAttackTimer
@onready var playerhitboxshape = $PlayerHitbox/CollisionShape2D
@onready var skeleton = $"../Skeleton"
@onready var staminaText = $"../CanvasLayer/Stamina"

@export_category("Movement")
@export var speed = 100
@export var runSpeed = 120
@export var acceleration = 2000
@export var friction = 450
@export var stamina = 1000

@export_category("Stats")
@export var healt : float = 100
@export var protection : float = 0
@export var baseDamage  : float = 5.5
var is_dead = false
var can_move = true
var is_running : bool = false
var can_run : bool = true
var attack_ip = false

#enemy vars
var enemy = null
var enemy_in_attack_range = false
var enemy_attack_cooldown = true

var input = Vector2.ZERO

func _ready():
	anim.play("idle")

func _process(delta):
	healtText.text = "Healt : " + str(healt)
	speedText.text = "Speed : " + str(speed)
	staminaText.text = "Stamina : " + str(stamina)
	

func _physics_process(delta):
	get_input()
	
	if healt <= 0:
		can_move = false
		die()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	#runnning
	if can_run and Input.is_action_pressed("run"):
		is_running = true
		speed = runSpeed
		if is_running == true:
			stamina -= 1
			if stamina <= 0:
				stamina = 0
				can_run = false
	else:
		speed = 100
		is_running = false

		
	#Animation thingies
	if input_direction.x == -1:
		anim.play("walk")
		player_sprite.flip_h = false
	if input_direction.x == 1:
		anim.play("walk")
		player_sprite.flip_h = true
	if input_direction.y == -1:
		anim.play("walk")
		player_sprite.flip_h = true
	if input_direction.y == 1:
		anim.play("walk")
		player_sprite.flip_h = false
	if velocity == Vector2(0, 0):
		if attack_ip == false:
			anim.play("idle")
			
	move_and_slide()


func die():
	healt  = 0
	queue_free()



#-------!!DANGER SIGNAL ZONE!!-------

