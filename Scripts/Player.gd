extends CharacterBody2D

const speed = 100
const acceleration = 2000
const friction = 450

var input = Vector2.ZERO
#var screen_size = get_viewport_rect().size

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
			
		
