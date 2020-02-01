extends Objet

class_name Particule

var damages = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body != self:
		body.damage(40)
		if body.is_enzyme():
			get_node("..").call_deferred("remove_child", self)
