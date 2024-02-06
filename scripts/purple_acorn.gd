extends StaticBody2D

var is_picked_up = false
		
func _ready():
	position.x = 650
	position.y = 320
	hide()

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		position.x = 650
		position.y = 320
		respawn()

# Function to handle picking up the power-up
func pickup():
	is_picked_up = true
	hide()  # Hide the power-up when it's picked up

# Function to respawn the power-up
func respawn():
	is_picked_up = false
	show()  # Show the power-up again
