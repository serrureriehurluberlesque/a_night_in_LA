extends Objet

class_name Particule

export var damages = 20

export var type = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _process(delta):
    if get_linear_velocity().length() < 10.0 and get_position().length() > get_node("../parois").cell_size:
        degradation_rate = 10.0
    else:
        degradation_rate = 2.0
        
func _on_Area2D_body_entered(body):
    if body != self:
        body.damage(damages)
        if body.is_enzyme():
            get_node("..").call_deferred("remove_child", self)
