extends Sprite

onready var enzymator = get_node("../enzymator")

func _ready():
    hide()

func _on_Area2D_input_event(viewport, event, shape_idx):
    print(shape_idx)
    if event.is_action_pressed("rightmouse"):
        if event.button_index == BUTTON_RIGHT and event.pressed:
            show()
            set_global_position(get_viewport_transform().inverse() * event.position)
            enzymator.set_goal(get_viewport_transform().inverse() * event.position)
