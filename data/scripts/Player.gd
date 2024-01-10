extends CharacterBody2D

# Car properties
var acceleration = 300
var max_speed = 400
var steering = 100
var wheel_base = 10.0
var steering_angle = 0.0

func _physics_process(delta):
	var input_steering = 0
	var input_acceleration = 0

	# Get input for steering
	if Input.is_action_pressed('steer_right'):
		if Input.is_action_pressed("reverse"):
			input_steering -= 1
		else:
			input_steering += 1
	if Input.is_action_pressed('steer_left'):
		if Input.is_action_pressed("reverse"):
			input_steering += 1
		else:
			input_steering -= 1
		#input_steering -= 1

	# Get input for acceleration
	if Input.is_action_pressed('forward'):
		input_acceleration += 1
	if Input.is_action_pressed('reverse'):
		input_acceleration -= 1

	# Apply acceleration
	if input_acceleration != 0:
		velocity += -transform.y * acceleration * input_acceleration * delta
		velocity = velocity.limit_length(max_speed)

	# Apply steering
	if input_steering != 0:
		steering_angle = steering * input_steering * delta
		# Clamp the steering angle to prevent over-steering
		steering_angle = clamp(steering_angle, -50, 50)
	else:
		# Return the steering wheel to the center position when not steering
		steering_angle = lerp(steering_angle, 0.0, 0.1)
		#rotation += steering_angle if velocity.length() > 10 else 0
		
	# Calculate the turning radius based on the steering angle and wheel base
	var turn_radius: float = wheel_base / sin(deg_to_rad(steering_angle))
	var angular_velocity: float = velocity.length() / turn_radius
	
	# Rotate the car based on the angular velocity
	rotation += angular_velocity * delta

	# Move the car
	move_and_slide()

	# Slow down the car when not accelerating
	if input_acceleration == 0:
		velocity = velocity.lerp(Vector2.ZERO, 0.05)

#extends CharacterBody2D
#
#@export var acceleration = 500
#@export var steering_speed = 120 
#@export var friction = 0.1
#@export var max_speed = 300
#
##var velocity = Vector2.ZERO
#var steering_angle = 0
#
#func get_input():
	#var turn_dir = 0
	#if Input.is_action_pressed('steer_left'):
		#turn_dir += 1
	#if Input.is_action_pressed('steer_right'): 
		#turn_dir -= 1
	#steering_angle = turn_dir * steering_speed
	#velocity = velocity.rotated(steering_angle)
	#
#func _physics_process(delta):
	#get_input()
	#
	#if Input.is_action_pressed("forward"):
		#velocity += Vector2(0, -acceleration).rotated(rotation)
	#else:
		#velocity *= 1 - friction
		#
	#velocity = velocity.limit_length(max_speed)
	#move_and_collide(velocity * delta)

#extends CharacterBody2D
#
#const speed = 300
#var wheel_base = 64
#var steering_angle = 15
#
#var steer_direction 
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#self.position = get_viewport_rect().size/2
	#
#
#func get_input():
	#velocity = Vector2.ZERO
	#if Input.is_action_pressed("forward"):
		#velocity = -transform.y * speed
	#var turn = 0
	#if Input.is_action_pressed("steer_right"):
		#turn += 1
	#if Input.is_action_pressed("steer_left"):
		#turn += -1
	#steer_direction = turn * deg_to_rad(steering_angle)
	#velocity = Vector2.ZERO
	#
#
#func calculate_steering(delta):
	#var rear_wheel = position - transform.y * wheel_base/2.0
	#var front_wheel = position + transform.y * wheel_base/2.0
	#rear_wheel += velocity * delta
	#front_wheel += velocity.rotated(steer_direction) * delta
	#var new_heading = (front_wheel - rear_wheel).normalized()
	#velocity = new_heading * velocity.length()
	#rotation = new_heading.angle()
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
	#get_input()
	#calculate_steering(delta)
	#move_and_slide()
