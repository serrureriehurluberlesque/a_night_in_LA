extends Objet

onready var target = get_global_position()

var max_speed = 10.0

func _physics_process(delta):
	
	if (target - get_global_position()).length() < 15.0:
		target = Vector2(rand_range(80.0, 240.0), 0).rotated(rand_range(-PI, PI))
	
	var d = target - get_global_position() 
	var i = 20 * max_speed / (max_speed + (get_linear_velocity()).length())
	apply_impulse(Vector2(), d.normalized() * i)

func go_to(global_position):
	target = global_position
