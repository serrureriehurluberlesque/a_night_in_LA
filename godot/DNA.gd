extends Objet

var activated = false
var indice

export var path_ref = "../../.."

onready var ref = get_node(path_ref)

onready var dnas = get_node("..")

func is_activated():
	return activated

var dna_health = 100 #btwn 0-100


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("PinJoint2D").set_node_b(ref.get_path())
	set_modulate(Color(0.3,0.3,0.3,1))


func _on_Objet_input_event(viewport, event, shape_idx):
	
	if event.is_action_pressed("leftmouse"):
		if event.button_index == BUTTON_LEFT and event.pressed:
			dnas.activate(indice)
			activated = true
			set_modulate(Color(1,1,1,1))

func deactivate():
	activated = false
	set_modulate(Color(0.3,0.3,0.3,1))
	
func _physics_process(delta):

	#dna_health -= getNode(Cell).get_dna_damage()
	#dna_health = min(max(dna_health, 0), 100)

	pass


