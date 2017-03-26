extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	
	_on_Timer_timeout()

func _on_Timer_timeout():
	var muertos = get_tree().get_root().get_node('main').get('num_death')
	self.set_text("Muertos: " + String(muertos))
	self.set_pos(Vector2(720,550))
	