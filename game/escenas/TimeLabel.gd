extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var s_count = 0
var m_count = 0

func _ready():
	
	_on_Timer_timeout()

func _on_Timer_timeout():
	
	self.set_text(String(m_count)+ ":" + String(s_count))
	self.set_pos(Vector2(512,0))
	
	s_count = s_count +1
	if (s_count == 60 ):
		s_count = 0
		m_count = m_count +1
	
	