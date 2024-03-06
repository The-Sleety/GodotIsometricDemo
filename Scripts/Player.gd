extends CharacterBody2D

class_name Player

@export_category("Texts and onreadies")
@onready var healtText = $"../CanvasLayer/Healt"
@onready var cooldown_timer = $CooldownTimer
@onready var anim = $AnimationPlayer
@onready var player_sprite = $Sprite2D
@onready var speedText = $"../CanvasLayer/Speed"


@export_category("Movement")
@export var speed = 100
@export var runSpeed = 120
@export var acceleration = 2000
@export var friction = 450

@export_category("Stats")
@export var healt : int = 100
@export var protection : float = 0
@export var baseDamage  : int = 0
var is_dead = false
var can_move = true
var is_running : bool = true

var input = Vector2.ZERO

func _ready():
	anim.play("idle")

func _process(delta):
	healtText.text = "Healt : " + str(healt)
	speedText.text = "Speed : " + str(speed)
	

func _physics_process(delta):
	get_input()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if Input.is_action_pressed("run"):
		is_running = true
		speed = runSpeed
	else:
		speed = 100
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
	move_and_slide()


	
func die():
	queue_free()
	
