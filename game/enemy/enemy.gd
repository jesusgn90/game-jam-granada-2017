extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Start
func _ready():
	add_to_group('enemies')
	set_fixed_process(true)
	
# Processing
func _fixed_process(delta):
	