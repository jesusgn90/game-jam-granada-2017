extends KinematicBody2D

# Laws of Physics
const GRAVITY = Vector2(0, 1000)

# Movement Constants
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_FRICTION = 20
const MOVEMENT_SPEED = 400
const ACCELERATION = 0.5
const JUMP_FORCE = 800
const JUMP_TIME_THRESHOLD = 0.2 # seconds

# Player Variables
var velocity = Vector2()
var can_jump = false
var jump_timer = 0
var bullet = load("res://escenas/bullet.tscn")
var textureprofile = load("res://imagenes/pjprof.png")
var texturedefault = load("res://imagenes/pj.png")

var vidas = 3

#get position
var left = false
var right = false

# Start
func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _input(event):
	if(Input.is_key_pressed(32)):
		var b = bullet.instance()
		b.init(left,right)
		var pos = get_pos()
		get_tree().get_root().get_node('main').add_child(b)
		if(right):
			print('derecha')
			b.set_pos(Vector2(pos.x + 40, pos.y + 20))
		else:
			print('izquierda')
			b.set_pos(Vector2(pos.x - 40, pos.y + 20))
		get_node('SamplePlayer2D').play('laser')

# Processing
func _fixed_process(delta):
	# Add Gravity
	velocity += GRAVITY * delta
	
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
		self.get_node("Sprite").set_texture(textureprofile)
		self.get_node("Sprite").set_flip_h(true)
		movement -= 1
	
	#self.get_node("Sprite").set_rot(0.0)
	# Input: RIGHT
	if(Input.is_action_pressed("ui_right")):
		self.get_node("Sprite").set_texture(textureprofile)
		self.get_node("Sprite").set_flip_h(false)
		movement += 1
	
	#Obtenemos la direccion
	if(velocity.x>0):
		right = true
	else:
		left = true
	
	#Ponemos la textura de frente si estamos parados
	if(velocity.x==0):
		self.get_node("Sprite").set_texture(texturedefault)

	# Set movement speed
	movement *= MOVEMENT_SPEED
	
	# Change horizontal velocity
	velocity.x = lerp(velocity.x, movement, ACCELERATION)
	
	# Input: Jump
	if(can_jump && Input.is_action_pressed("ui_up")):
		get_node('SamplePlayer2D2').play('jump')
		velocity.y -= JUMP_FORCE
		jump_timer = JUMP_TIME_THRESHOLD
		
	
		#Obtenemos la direccion
	if(velocity.x>0):
		right = true
		left = false
	else:
		left = true
		right = false
	
	if(is_colliding() && get_collider().is_in_group('enemies')):
		if(vidas > 0):
			vidas -= 1
			print('VIDAS: ', vidas)
		else:
			get_tree().change_scene('res://escenas/game-over.tscn')