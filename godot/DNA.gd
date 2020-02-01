extends Objet

var activated = false
var indice

onready var dnas = get_node("..")

func is_activated():
    return activated

# Called when the node enters the scene tree for the first time.
func _ready():
    set_modulate(Color(0.3,0.3,0.3,1))

func _on_Objet_input_event(viewport, event, shape_idx):
    if event.is_action_pressed("leftmouse"):
        if event.button_index == BUTTON_LEFT and event.pressed and not dead:
            dnas.activate(indice)
            activated = true
            set_modulate(Color(1,1,1,1))

func deactivate():
    if not dead:
        activated = false
        set_modulate(Color(0.3,0.3,0.3,1))
	
func _physics_process(delta):
    if dead and hp >= max_hp * 0.3:
        get_node("..").repaired(indice)
        dead = false
        
	#dna_health -= getNode(Cell).get_dna_damage()
	#dna_health = min(max(dna_health, 0), 100)

    pass

func pin(node):
    pass
    
#    var pin = PinJoint2D.new()
#    pin.set_node_b(self.get_path())
#    pin.set_node_a(node.get_path())
#    add_child(pin)

func die():
    get_node("..").dna_die(indice)
    dead = true
    set_modulate(Color(0.5,0.0,0.0,0.4))
