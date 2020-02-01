extends RigidBody2D
class_name Objet


export var hp = 100.0
export var enzym = false
export var degradation_rate = 0.0

var dead = false

export var factor_repair_paroi = 0.0
export var factor_repair_general = 1.0

var delayed_modulate_timing = 0

onready var max_hp = hp

func damage(n):
    hp -= n
    if hp <= 0.1 and not dead:
        die()
    var ratio = hp / max_hp
    set_modulate(Color(1, ratio, ratio, 1))
    update_modulate()

func is_enzyme():
    return enzym

func _physics_process(delta):
    if degradation_rate > 0:
        hp -= max(0.0, delta * degradation_rate)
        
        if hp <= 0.1 and not dead:
            die()
        else:
            update_modulate()  # gourmand?
    
    if delayed_modulate_timing > 0:
        delayed_modulate_timing -= 1
        if delayed_modulate_timing <= 0:
            update_modulate()

func die():
    get_node("..").call_deferred("remove_child", self)

func repair(f, g=0.0):
    var t = f * factor_repair_general + g * factor_repair_paroi
    hp += t
    hp *= 0.99
    hp += min(max_hp, hp) / 100.0
    
    if not dead and t > 0.000001:
        update_modulate(true)
        delay_modulate()

func update_modulate(repairing=false):
    if repairing:
        var c = Color(0.1, 1, 0.5, 1)
        set_modulate(c)
    else:
        var ratio = hp / max_hp
        var c = Color(1, ratio, ratio, 1)
        set_modulate(c)

func delay_modulate():
    delayed_modulate_timing = 2
