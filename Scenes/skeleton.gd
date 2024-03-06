extends CharacterBody2D

@onready var anim = $"Animated Sprite"



@export var speed : float = 50
@export var health = 100
var damage = 10

var dead = false 
var player_in_area = false
var player 

func _ready():
	dead = false
	
func _physics_process(delta):
	if !dead:
		$DetectionArea/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position - position) / speed
			anim.play("walk")
			if (player.position.x - position.x) < 0:
				anim.flip_h = true
			else:
				anim.flip_h = false
		else:
			anim.play("idle")
			
			
	if dead:
		$DetectionArea/CollisionShape2D.disabled = true

func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		player_in_area = true
		player = body


func _on_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		player_in_area = false
		player = body


func _on_hitbox_area_entered(area):
	pass # Replace with function body.
