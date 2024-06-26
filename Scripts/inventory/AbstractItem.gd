extends Sprite2D

class_name abstractItem

@onready var collision = $Area2D/CollisionShape2D

@export var stats : Item
@export var skill :  Skill

var is_on_item = false

func _ready():
	if stats != null:
			texture = stats.icon

func _on_player_entered(body):
	if body.name == "Player":
		call_deferred("reparent", body.find_child("Weapon"))
		position = body.position
		body.add_item(stats, skill)
		collision.call_deferred("set_disabled", true)
		self.hide()


