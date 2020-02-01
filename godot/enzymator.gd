extends Node2D

var cell_size = 5.0
var noyau_size = 1.0

var enzimation = 0.3

onready var packed_particule = {}
var chance_to_particule = 0.0

var prod_n = 2
var prod_coef = {}

func set_prod(dict):
    var t = 0.0
    for i in range (prod_n):
        prod_coef[i] = dict[i]
        t += dict[i]
    
func _ready():
    for i in range (prod_n):
        packed_particule[i] = load("res://Enzyme" + str(i+1) + ".tscn")
        prod_coef[i] = 1.0 / prod_n

func _process(delta):
    chance_to_particule += delta * enzimation
    if chance_to_particule > 1:
        emit_particule()
        chance_to_particule -= 1

func emit_particule():
    var x = rand_range(noyau_size, cell_size)
    var s = rand_range(10, 50)

    var f = randf()
    
    var i = 0
    var t = 0
    for j in range(prod_n):
        t += prod_coef[j]
        if t > f:
            break
        else:
            i += 1
            
    if i < prod_n:
        var particule = packed_particule[i].instance()
        if i == 0:
            variate_sprite(particule.get_node("Sprite"), "res://sprites/Enzyme_" + str(randi() % 2 + 1) + ".png")

        particule.set_global_position(Vector2(0.0, x).rotated(rand_range(-PI, PI)))
        particule.apply_impulse(Vector2(), - Vector2(0.0, s).rotated(rand_range(-PI, PI)))
        particule.set_global_rotation(rand_range(-PI, PI))
        add_child(particule)
    
func variate_sprite(node, ressource):
    var img = Image.new()
    var itex = ImageTexture.new()
    img.load(ressource)
    itex.create_from_image(img)
    node.texture = itex
    
func get_number_enzyme():
    return get_child_count()

func set_goal(global_position, r):
    for child in get_children():
        if (child.get_global_position() - global_position).length() < r:
            child.go_to(global_position)

func boost(f):
    chance_to_particule += f

func clamped(vector):
    return (vector - get_global_position()).clamped(get_node("../parois").cell_size) + get_global_position()
