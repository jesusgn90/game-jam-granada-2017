extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Laws of Physics
const GRAVITY = Vector2(0, 1000)

# Movement Constants
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_FRICTION = 20
const MOVEMENT_SPEED =100
const ACCELERATION = 0.5
const JUMP_FORCE = 300
const JUMP_TIME_THRESHOLD = 0.2 # seconds

# Player Variables
var velocity = Vector2()
var can_jump = false
var jump_timer = 0







# Start
func _ready():
	add_to_group('enemies')
	set_fixed_process(true)
	
# Processing
func _fixed_process(delta):
# Add Gravity
	
	#get_tree().get_root().get_node('main').get_node('enemy')
	
	
	# Increment time
	jump_timer += delta
	
	# Old:
	# move(velocity)
	
	# New:
	# Move and Slide
	velocity = move_and_slide(velocity, FLOOR_NORMAL, SLOPE_FRICTION)
	
	# Jump Timer Controller
	if(is_move_and_slide_on_floor()):
		jump_timer = 0
	
	# Can jump?
	can_jump = jump_timer < JUMP_TIME_THRESHOLD
	
	# Movement
	var movement = 0
	
	# Input: LEFT
	if(Input.is_action_pressed("ui_left")):
		movement -= 1
	
	# Input: RIGHT
	if(Input.is_action_pressed("ui_right")):
		movement += 1
	
	print(get_tree().get_root().get_node('main').get_node('player').get_pos())
	
	if(get_tree().get_root().get_node('main').get_node('player').get_pos().x>self.get_pos().x):
		movement +=1
	else:
		movement -=1
	
	# Set movement speed
	movement *= MOVEMENT_SPEED
	
	# Change horizontal velocity
	velocity.x = lerp(velocity.x, movement, ACCELERATION)
	
	# Input: Jump
	if(can_jump && Input.is_action_pressed("ui_up")):
		velocity.y -= JUMP_FORCE
		jump_timer = JUMP_TIME_THRESHOLD

	if(is_colliding() && get_collider().is_in_group('enemies')):
		get_node('SamplePlayer2D').play('dead')
		print(get_tree().get_root().get_node('main').get_node('enemy').free())

	