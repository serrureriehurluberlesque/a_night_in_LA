extends Objet

export var path_ref = "../.."

onready var ref = get_node(path_ref)

var bit_paroi = 0

onready var default_collision_mask = get_collision_layer_bit(bit_paroi)

# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("PinJoint2D").set_node_b(ref.get_path())


func _physics_process(_delta) :
    if hp < 0.0:
        set_collision_layer_bit(bit_paroi, false)
    else:
        set_collision_layer_bit(bit_paroi, default_collision_mask)
    
    if dead and hp >= max_hp * 0.3:
        set_collision_layer_bit(1, default_collision_mask)
        dead = false
    
    var stress_level = get_node("../..").get_stress_level()
    var stress_amplificator = get_node("..").stress_amplificator
    
    if stress_level > 0 :
        degradation_rate = base_degradation_rate * stress_amplificator

func die():
    set_collision_layer_bit(1, false)
    set_modulate(Color(0.5,0.0,0.0,0.4))
    dead = true

func repair_animate(emit, t):
    var particle = get_node("Node/Particles2D")
    if emit and not particle.is_emitting():
        particle.amount = t * 2
        particle.set_emitting(true)
        particle.set_global_position(get_global_position())
    elif not emit and particle.is_emitting():
        particle.set_emitting(false)
    


func _on_Objet_body_entered(body):
    if body.particule:
        get_node("collision").play()
