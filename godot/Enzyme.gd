extends Objet

onready var target = get_global_position()

export var max_speed = 8.0
export var paroi_repair = 0.0
export var general_repair = 0.0
export var enzyme_repair = 0.0
export var repair_range = 35.0
var nearest_target
var d_nearest
var mardise

export var stress_amplificator = 1.2

func _ready():
    reset_target()
    
func _physics_process(delta):
    mardise += delta
    if (target - get_global_position()).length() < mardise:
        reset_target()
        target = get_target()
        target = get_node("..").clamped(target)
    
    var d = target - get_global_position()
    var i = 20 * max_speed / (max_speed + (get_linear_velocity()).length())
    apply_impulse(Vector2(), d.normalized() * i * delta)
    
    
    for body in get_node("Area2D").get_overlapping_bodies():
        if (body.get_global_position() - get_global_position()).length() < repair_range:
            body.repair(general_repair, paroi_repair)
            
        
    var stress_level = get_node("../../../Cellule").get_stress_level()

    if stress_level > 0 :
        degradation_rate = base_degradation_rate * stress_amplificator
        
            
func get_target():
    d_nearest = 1000.0
    for body in get_node("Area2D").get_overlapping_bodies():
        var d = (body.get_global_position() - get_global_position()).length()
        if d < d_nearest and d > repair_range:
            nearest_target = body
            d_nearest = d
            
    var best_target
    if nearest_target:
        best_target = nearest_target.get_global_position()
    else:
        best_target = (get_global_position() + Vector2(rand_range(0.0, 140.0), 0).rotated(rand_range(-PI, PI)))
    return best_target
    
func reset_target():
    d_nearest = 1000.0
    nearest_target = null
    mardise = 15.0

func go_to(global_position):
    target = global_position
