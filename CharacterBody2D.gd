extends CharacterBody2D

	
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite = $Sprite2D



func _physics_process(delta):
	
	floor_max_angle == 6.28318530718 
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_key_pressed(KEY_R):
		position.x = 20
		position.y = 7
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY	

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if velocity.x < 0:
		# Set the sprite frame for walking left
		sprite.flip_h = true  
	elif velocity.x > 0:
		# Set the sprite frame for walking right
		sprite.flip_h = false  
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	move_and_slide()
