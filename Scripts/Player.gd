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

@export_category("Movement")
@export var speed = 100
@export var runSpeed = 120
@export var acceleration = 2000
@export var friction = 450

@export_category("Stats")
@export var healt : float = 100
@export var protection : float = 0
@export var baseDamage  : float = 5.5
var is_dead = false
var can_move = true
var is_running : bool = true
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
	

func _physics_process(delta):
	enemyAttack()
	get_input()
	
	if healt <= 0:
		die()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if Input.is_action_pressed("run"):
		is_running = true
		speed = runSpeed
	else:
		speed = 100
		
	if Input.is_action_just_pressed("Attack"):
		print(	"attacking")
		Global.player_attacking = true
		attack_ip = true
		deal_attack_timer.start()
		anim.play("attack")
		
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


func enemyAttack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		healt = healt - enemy.damage
		healt += protection / 2
		enemy_attack_cooldown = false
		cooldown_timer.start( )
		print(healt)

func die():
	healt  = 0
	queue_free()



#-------!!DANGER SIGNAL ZONE!!-------

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true
		enemy = body
 
func _on_player_hitbox_body_exited(body):
	enemy_in_attack_range = false
	enemy = null
	
func _on_cooldown_timer_timeout():
	enemy_attack_cooldown = true

func _on_deal_attack_timer_timeout():
	deal_attack_timer.stop()
	Global.player_attacking = false
