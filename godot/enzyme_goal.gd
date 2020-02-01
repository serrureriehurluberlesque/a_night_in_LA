extends Sprite

onready var enzymator = get_node("../enzymator")
var r = 30.0
var pressing = false
var pos = Vector2()

func _ready():
    hide()

func _input(event):
    if event.is_action_pressed("rightmouse"):
        if event.button_index == BUTTON_RIGHT and event.pressed:
            var g_pos = get_viewport_transform().inverse() * event.position * get_node("/root/lvl/Camera2D").zoom.x * get_node("/root/lvl/Camera2D").zoom.x
            if (get_node("..").get_global_position() - g_pos).length() < get_node("../parois").cell_size:
                show()
                set_global_position(g_pos)
                pressing = true
                pos = g_pos

func _physics_process(delta):
    if pressing:
        r = min(500.0, r + 200 * delta)
        var f = r / 300.0
        scale = Vector2(f, f)
        var c = get_modulate()
        c.a = 1.0
        set_modulate(c)
        
    if Input.is_action_just_released("click"):
        pressing = false
        enzymator.set_goal(pos, r)
        r = 30.0
    
    if not pressing:
        var c = get_modulate()
        c.a = max(0.0, c.a - delta / 5.0)
        set_modulate(c)
