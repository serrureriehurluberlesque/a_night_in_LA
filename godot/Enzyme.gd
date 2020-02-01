extends Objet

onready var target = get_global_position()

export var max_speed = 8.0
export var paroi_repair = 0.0
export var general_repair = 0.0

func _physics_process(delta):
	if (target - get_global_position()).length() < 35.0:
		target = (get_global_position() + Vector2(rand_range(0.0, 140.0), 0).rotated(rand_range(-PI, PI)))
		target = get_node("..").clamped(target)
	
	var d = target - get_global_position() 
	var i = 20 * max_speed / (max_speed + (get_linear_velocity()).length())
	apply_impulse(Vector2(), d.normalized() * i * delta)
	
	for body in get_node("Area2D").get_overlapping_bodies():
		body.repair(general_repair, paroi_repair)

func go_to(global_position):
	target = global_position
