extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	
	_on_Timer_timeout()

func _on_Timer_timeout():
	var level = get_tree().get_root().get_node('main').get('current_level')
	self.set_text("Nivel: " + String(level))
	self.set_pos(Vector2(512,550))
	