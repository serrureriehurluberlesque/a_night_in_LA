extends RigidBody2D
class_name Objet


export var hp = 100.0

func damage(n):
	hp -= n
	var ratio = hp / 100.0
	set_modulate(Color(1, ratio, ratio, 1)) 

func is_enzyme():
	return false
