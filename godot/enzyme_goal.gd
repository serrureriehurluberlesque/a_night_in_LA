extends Sprite

onready var enzymator = get_node("../enzymator")

func _ready():
    hide()

func _input(event):
    print("jeu enzyme")
    if event.is_action_pressed("rightmouse"):
        if event.button_index == BUTTON_RIGHT and event.pressed:
            show()
            set_global_position(get_viewport_transform().inverse() * event.position)
            enzymator.set_goal(get_viewport_transform().inverse() * event.position)
