extends Objet

onready var target = get_global_position()

var max_speed = 2.0

func _physics_process(delta):
    if (target - get_global_position()).length() < 35.0:
        target = (get_global_position() + Vector2(rand_range(0.0, 140.0), 0).rotated(rand_range(-PI, PI))).clamped(200.0)
    
    var d = target - get_global_position() 
    var i = 20 * max_speed / (max_speed + (get_linear_velocity()).length())
    apply_impulse(Vector2(), d.normalized() * i * delta)

func go_to(global_position):
    target = global_position
