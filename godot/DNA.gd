extends Objet

var activated = false
var indice

onready var dnas = get_node("..")

func is_activated():
	return activated

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Objet_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("leftmouse"):
		if event.button_index == BUTTON_LEFT and event.pressed and not dead:
			dnas.activate(indice)
			activated = true

func deactivate():
	if not dead:
		activated = false
	
func _physics_process(_delta):
	if dead and hp >= max_hp * 0.3:
		# get_node("..").repaired(indice)
		dead = false
	
	var c = get_modulate()
	if activated:
		c.r = 1.0
	else:
		c.r = 0.3
	set_modulate(c)

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


func repair_animate(emit, t):
	var particle = get_node("Particles2D")
	var a = floor(t * 100)
	if particle.amount != a:
		particle.amount = a
	
	if emit and not particle.is_emitting():
		particle.set_emitting(true)
	elif not emit and particle.is_emitting():
		particle.set_emitting(false)
