extends Sprite2D

@onready var collision = $Area2D/CollisionShape2D

@export var stats : Item
@export var skill :  Skill

func _ready():
	if stats != null:
			texture = stats.icon
			


func _on_player_entered(body):
	call_deferred("reparent", body.find_child("Weapons"))
	position = body.position
	self.queue_free()
	body.add_item(stats, skill)
	collision.call_deferred("set_disabled", true)


