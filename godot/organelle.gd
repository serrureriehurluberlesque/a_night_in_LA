extends Objet

export var path_ref = "../.."

onready var ref = get_node(path_ref)

func _ready():
    get_node("PinJoint2D").set_node_b(ref.get_path())

func _physics_process(_delta) :
    if dead and hp >= max_hp * 0.3:
        dead = false
        
func die():
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
