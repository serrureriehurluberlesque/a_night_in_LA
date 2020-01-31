extends Objet

var activated = false
var indice

func is_activated():
    return activated

var dna_health = 100 #btwn 0-100


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func _on_Objet_input_event(viewport, event, shape_idx):
    
    if event.is_action_pressed("leftmouse"):
        if event.button_index == BUTTON_LEFT and event.pressed:
            activated = true

func _physics_process(delta):

    #dna_health -= getNode(Cell).get_dna_damage()
    #dna_health = min(max(dna_health, 0), 100)

    pass



