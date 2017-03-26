extends Node2D

var player = load("res://escenas/Player.tscn")
var babosa = load("res://escenas/EnemyEasy.tscn")
var background = load("res://escenas/Background.tscn")
var back = background.instance()
var p = player.instance()



func _ready():
	# Setting background
	self.add_child(back)
	
	# Setting player

	self.add_child(p)
	p.set_pos(Vector2(20,60)) 
	
	
	_on_Timer_timeout()
	


func _on_Timer_timeout():
	var b = babosa.instance()
	self.add_child(b)
	b.set_pos(Vector2(rand_range(0,global.RES_X),rand_range(0,global.RES_Y)))
