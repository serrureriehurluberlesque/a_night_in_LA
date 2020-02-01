extends Node2D

var cell_size = 200.0
var noyau_size = 50.0

var enzimation = 0.2

onready var packed_particule = {}
var chance_to_particule = 0.0

func _ready():
    for i in range (4):
        packed_particule[i] = load("res://Enzyme" + str(i+1) + ".tscn")
        
func _process(delta):
    chance_to_particule += delta * enzimation
    if chance_to_particule > 1:
        emit_particule()
        chance_to_particule -= 1

func emit_particule():
    var x = rand_range(noyau_size, cell_size)
    var s = rand_range(10, 50)

    var i = randi() % 3
    var particule = packed_particule[i].instance()
        
    particule.set_global_position(Vector2(0.0, x).rotated(rand_range(-PI, PI)))
    particule.apply_impulse(Vector2(), - Vector2(0.0, s).rotated(rand_range(-PI, PI)))
    particule.set_global_rotation(rand_range(-PI, PI))
    add_child(particule)
	
func get_number_enzyme():
    return get_child_count()

func set_goal(global_position):
    for child in get_children():
        if (child.get_global_position() - global_position).length() < 150.0:
            child.go_to(global_position)

func boost(f):
<<<<<<< HEAD
	chance_to_particule += f
=======
    chance_to_particule += f

func clamped(vector):
    return (vector - get_global_position()).clamped(get_node("../parois").cell_size) + get_global_position()
>>>>>>> a375a926d4df7b21c489314cde6e803786fcc9f9
