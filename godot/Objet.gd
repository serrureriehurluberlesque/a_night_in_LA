extends RigidBody2D
class_name Objet


export var hp = 100.0
export var enzym = false
export var particule = false
export var degradation_rate = 0.0
export var chance_to_dechet = 0.2

onready var base_degradation_rate = degradation_rate

var dead = false

export var factor_repair_paroi = 0.0
export var factor_repair_general = 1.0
export var factor_repair_enzyme = 0.0

var delayed_modulate_timing = 0

export var repair_c = Color(0.1, 1, 0.5, 1)

onready var max_hp = hp

var die_image = {}

var die_i = 0

func _ready():
    for i in range(6):
        die_image[i] = load("res://sprites/Animations/Sparu/00" + str(i) + ".png")
        
func damage(n):
    hp -= n
    if hp <= 0.1 and not dead:
        die()
    var ratio = hp / max_hp
    set_modulate(Color(1, ratio, ratio, 1))
    update_modulate()
    damage_animate(true, n)

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
            repair_animate(false, 0.0)

func die():
    get_node("AnimationPlayer").play("death")

func next_die():
    get_node("Sprite").texture = die_image[die_i]
    die_i += 1

func finaldie():
    if randf() < chance_to_dechet:
        create_dechet()
    get_node("..").call_deferred("remove_child", self)

func repair(f, g=0.0):
    var t = f * factor_repair_general + g * factor_repair_paroi
    hp += t
    hp *= 0.99
    hp += min(max_hp, hp) / 100.0
    
    if not dead and t > 0.000001:
        update_modulate(true)
        delay_modulate()
        repair_animate(true, t)

func update_modulate(repairing=false):
    if repairing:
        set_modulate(repair_c)
    else:
        var ratio = hp / max_hp
        var c = Color(1, ratio, ratio, 1)
        set_modulate(c)

func delay_modulate():
    delayed_modulate_timing = 2

func repair_animate(_B, _f):
    pass

func damage_animate(emit, t):
    var particle = get_node("Node/Particles2D_moins")
    if emit and not particle.is_emitting():
        particle.amount = t / 2
        particle.set_emitting(true)
        particle.set_global_position(get_global_position())
    elif not emit and particle.is_emitting():
        particle.set_emitting(false)

func create_dechet():
    
