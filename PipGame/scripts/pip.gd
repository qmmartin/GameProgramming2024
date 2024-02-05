extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var jumps = 1

# Reference to the camera node
@onready var Camera = $Camera
@onready var sprite = $Sprite2D

#var purple_acorn = load("res://scenes/purple_acorn.tscn")
#var purple_acorn = 1


# Reference to the camera's original parent
var camera_original_parent = null

func _ready():
	# Save the original parent of the camera
	camera_original_parent = Camera.get_parent()

func _physics_process(delta):
	
	# Add the gravity.
	if position.y > 500:
		# Player is falling, stop following
		stop_following_player()
	elif position.y <= 500:
		$pip_fall.play()
		# Player is not falling, follow the player
		follow_player()

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_key_pressed(KEY_R):
		position.x = 580
		position.y = 350
		velocity.x = 0
		velocity.y = 0
		jumps = 1

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$walk_forest.play()
		await get_tree().create_timer(0.53).timeout
		$walk_forest.stop()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# DASHING
	if velocity.x>0: #DASH RIGHT
		if Input.is_action_just_pressed("ui_page_up"):
			velocity.x += 500
	if velocity.x<0: #DASH LEFT
		if Input.is_action_just_pressed("ui_page_up"):
			velocity.x -= 500

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x < 0:
		# Set the sprite frame for walking left
		sprite.flip_h = true
	elif velocity.x > 0:
		# Set the sprite frame for walking right
		sprite.flip_h = false
		
	#body_entered(purple_acorn)

	move_and_slide()

# Function to make the camera follow the player
func follow_player():
	Camera.position.y = 0
	#Camera.position.x = position.x - 500
	# If the camera was detached, attach it back to the player
	if Camera.get_parent() != camera_original_parent:
		camera_original_parent.add_child(Camera)

# Function to make the camera stop following the player and fix to a point
func stop_following_player():
	Camera.position.x = 0
	# Detach the camera from the player
	if Camera.get_parent() == camera_original_parent:
		camera_original_parent.remove_child(Camera)
	# Set the camera position to a fixed point
	Camera.position.y = 0
	
#func body_entered(body):
	#if body.has_method("pickup"):
		#body.pickup()
