extends CharacterBody2D

class_name Player

@export_category("Texts and onreadies")
@onready var healtText = $"../CanvasLayer/Healt"

@export_category("Movement")
@export var speed = 100
@export var acceleration = 2000
@export var friction = 450

@export_category("Stats")
@export var healt = 100
@export var protection = 0
@export var baseDamage = 0
var is_dead = false
var can_move = true

var input = Vector2.ZERO

func _process(delta):
	healtText.text = "Healt : " + str(healt)

func _physics_process(delta):
	player_movement(delta)

func cartesian_to_isometric(cartesian): 
	var screen_pos = Vector2()
	screen_pos.x = cartesian.x - cartesian.y
	screen_pos.y = (cartesian.x + cartesian.y) /2
	return screen_pos

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized()


func player_movement(delta):
	input = get_input()
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		#velocity += (input * acceleration * delta)	
		velocity = velocity.limit_length(speed)
		
		velocity += cartesian_to_isometric(input * acceleration * delta)
	move_and_slide()
	
	
func GetDamaged():
	if healt != 0:
		healt -= 5
	if healt == 0:
		die()

func die():
	queue_free()
