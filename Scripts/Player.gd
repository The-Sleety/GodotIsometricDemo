extends CharacterBody2D

class_name Player

@export_category("Texts and onreadies")
@onready var healtText = $"../CanvasLayer/DebugMenu/Healt"
@onready var anim = $AnimationPlayer
@onready var player_sprite = $Sprite2D
@onready var speedText = $"../CanvasLayer/DebugMenu/Speed"
@onready var skeleton = $"../Skeleton"
@onready var staminaText = $"../CanvasLayer/DebugMenu/Stamina"
@onready var hotbar = $UI/Hotbar

@export var Item_obj : PackedScene

@export_category("Movement")
@export var speed = 100
@export var runSpeed = 120
@export var friction = 450

@export_category("Stats")
@export var maxStamina = 1000
@export var stamina = 1000
@export var maxHealth :float = 100
@export var healt : float = 100
@export var maxProtection : float = 100
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

func _process(_delta):
	pass
	#healtText.text = "Healt : " + str(healt)
	#speedText.text = "Speed : " + str(speed)
	#staminaText.text = "Stamina : " + str(stamina)
	

func _physics_process(_delta):
	get_input()
	
	if can_move == false:
		velocity = Vector2(0, 0)
	else:
		can_move = true
	
	if healt <= 0:
		can_move = false
		die()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if can_move:
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



func add_item(stats,skill):
	hotbar.add_item(stats,skill)

func die():
	healt  = 0
	queue_free()


#-------!!DANGER SIGNAL ZONE!!-------

