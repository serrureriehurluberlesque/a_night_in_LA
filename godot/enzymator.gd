extends Node2D

var cell_size = 200.0
var noyau_size = 50.0

var enzimation = 0.4

onready var packed_particule = load("res://Enzyme.tscn")
var chance_to_particule = 0.0

func _process(delta):
	chance_to_particule += delta * enzimation
	if chance_to_particule > 1:
		emit_particule()
		chance_to_particule -= 1

func emit_particule():
	var x = rand_range(noyau_size, cell_size)
	var s = rand_range(10, 50)
	
	var particule = packed_particule.instance()
	particule.set_global_position(get_global_position() + Vector2(0.0, x).rotated(rand_range(-PI, PI)))
	particule.apply_impulse(Vector2(), - Vector2(0.0, s).rotated(rand_range(-PI, PI)))
	particule.set_global_rotation(rand_range(-PI, PI))
	add_child(particule)
	
func get_number_enzyme():
	return get_child_count()

func set_goal(global_position):
	for child in get_children():
		child.go_to(global_position)
