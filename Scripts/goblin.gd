extends CharacterBody2D

@onready var anim = $"Animated Sprite"
@onready var player = $"../Player"



@export var speed : float = 40
@export var health : float = 100
var damage : float = 3.5

var dead = false 
var player_in_area = false

func _ready():
	dead = false
	
func _physics_process(_delta):
	
	if !dead:
		$DetectionArea/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position - position) / speed
			anim.play("run")
			if (player.position.x - position.x) < 0:
				anim.flip_h = true
			else:
				anim.flip_h = false
		else:
			anim.play("idle")
			
			
	if dead:
		$DetectionArea/CollisionShape2D.disabled = true


#-------!!DANGER SIGNAL ZONE!!-------

func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		player_in_area = true
		player = body


func _on_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		player_in_area = false
		player = body
