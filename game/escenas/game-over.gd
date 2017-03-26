extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node('SamplePlayer2D').play('dead')
	set_fixed_process(true)

# Processing
func _fixed_process(delta):
	if(Input.is_key_pressed(65)):
		get_tree().change_scene('res://escenas/main.tscn')
	
