extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	
	_on_Timer_timeout()

func _on_Timer_timeout():
	var Nenemy = get_tree().get_root().get_node('main').get('num_enemy')
	self.set_text("Numero de Enemigos: " + String(Nenemy))
	self.set_pos(Vector2(0,550))
	