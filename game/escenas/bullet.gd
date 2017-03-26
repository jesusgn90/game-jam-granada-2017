# Laws of Physics
const GRAVITY = Vector2(0, 0)

# Movement Constants
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_FRICTION = 20
const MOVEMENT_SPEED = 1
const ACCELERATION = 1.0

# Player Variables
var velocity = Vector2()
var previous_dist = 0
# Movement
var movement = 0
var left = false
var right = false

func init(l, r):
	left = l
	right = r

func _ready():
	pass
	set_fixed_process(true)
	
func _fixed_process(delta):
	# Add Gravity
	velocity += GRAVITY * delta

	#var player_posx = get_tree().get_root().get_node('main').get_child(p).get_pos().x
	var player = get_tree().get_root().get_node('main').get('p')
	var player_posx = player.get_pos().x
	var dist=abs(player_posx-self.get_pos().x)
	
	if(left):
		movement -= 5
	else:
		movement += 5
	
	
	
	# Set movement speed
	movement *= MOVEMENT_SPEED
	
	# Change horizontal velocity
	#velocity.x = lerp(velocity.x, movement, ACCELERATION)
	velocity.x = movement
	# Move and Slide
	velocity = move_and_slide(velocity, FLOOR_NORMAL, SLOPE_FRICTION)

	if(is_colliding()):
		self.free()
	