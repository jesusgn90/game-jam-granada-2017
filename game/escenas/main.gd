extends Node2D

var player = load("res://escenas/Player.tscn")
var babosa = load("res://escenas/EnemyEasy.tscn")
var background = load("res://escenas/Background.tscn")
var saltamontes = load("res://escenas/Saltamontes.tscn")
var back = background.instance()
var p = player.instance()

# counters
var num_enemy = 0
var num_death = 0
# levels
var current_level = 1
var Nlevel = 10

func aumentar_muertos():
	num_death += 1

func _ready():
	get_node('SamplePlayer2D').play('theme')
	# Setting background
	self.add_child(back)
	
	self.add_child(p)
	p.set_pos(Vector2(20,60)) 
	_on_Timer_timeout()
	


func _on_Timer_timeout():
	if (num_enemy < current_level*Nlevel):
			# variables
		#var b = babosa.instance()
		var b = babosa.instance()
		self.add_child(b)
		b.set_pos(Vector2(rand_range(0,global.RES_X),20))
		num_enemy = num_enemy + 1
		if(num_enemy % 5 == 0):
			var s = saltamontes.instance()
			self.add_child(s)
			s.set_pos(Vector2(rand_range(0,global.RES_X),20))
			num_enemy = num_enemy + 1
	else:
		current_level += 1