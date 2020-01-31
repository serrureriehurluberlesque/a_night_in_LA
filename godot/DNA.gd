extends Objet


var indice = 1

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.



func _on_Objet_input_event(viewport, event, shape_idx):
    
    if event.is_action_pressed("leftmouse"):
        if event.button_index == BUTTON_LEFT and event.pressed:
            get_node("../../..").set_indice(indice)
