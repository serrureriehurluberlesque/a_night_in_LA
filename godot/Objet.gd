extends RigidBody2D
class_name Objet


export var hp = 100.0
export var enzym = false
export var degradation_rate = 0.0

var dead = false

onready var max_hp = hp

func damage(n):
    hp -= n
    if hp <= 0.1 and not dead:
        die()
    var ratio = hp / max_hp
    set_modulate(Color(1, ratio, ratio, 1))

func is_enzyme():
    return enzym

func _physics_process(delta):
    hp -= max(0.0, delta * degradation_rate)

func die():
    get_node("..").call_deferred("remove_child", self)

func repair(f):
    hp += f
    hp *= 0.99
    hp += min(max_hp, hp) / 100.0
    
    if not dead:
        var ratio = hp / max_hp
        set_modulate(Color(1, ratio, ratio, 1))
