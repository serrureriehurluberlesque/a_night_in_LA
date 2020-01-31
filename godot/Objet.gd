extends RigidBody2D
class_name Objet


export var hp = 100.0
export var enzym = false
export var degradation_rate = 0.0

func damage(n):
    hp -= n
    var ratio = hp / 100.0
    set_modulate(Color(1, ratio, ratio, 1)) 

func is_enzym():
    return enzym

func _physics_process(delta):
    hp -= max(0.0, delta * degradation_rate)
