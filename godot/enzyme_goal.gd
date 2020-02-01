extends Sprite

onready var enzymator = get_node("../enzymator")

func _ready():
    hide()

func _input(event):
    if event.is_action_pressed("rightmouse"):
        if event.button_index == BUTTON_RIGHT and event.pressed:
            var g_pos = get_viewport_transform().inverse() * event.position * get_node("/root/lvl/Camera2D").zoom.x * get_node("/root/lvl/Camera2D").zoom.x
            if (get_node("..").get_global_position() - g_pos).length() < get_node("../parois").cell_size:
                show()
                set_global_position(g_pos)
                enzymator.set_goal(g_pos)
#
#func _process(delta):
#    var c = get_modulate()
#    c.a = max(c.a - delta / 20.0, 0)
#    set_modulate(c)
