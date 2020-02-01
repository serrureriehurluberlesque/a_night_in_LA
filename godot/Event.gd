extends Node2D

export var Fat_level = 0
export var OH_level = 0
export var cocaine_level = 0
export var cocaethylene_level = 0
export var virus_level = 0

var oh_rate
var fat_rate

export var time = 60.0
export var time_chill = 0.0
export var time_absolu = 60.0
export var text = "And the next level"

export var particules_path = ".."
onready var particules_node_base = get_node(particules_path)
onready var packed_particules = {'OH' : load("res://OH.tscn"),
    'Particule' : load("res://Particule.tscn"),
    'Fat' : load("res://Fat.tscn")}

var time_since_beg = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("../Cellule").set_level(OH_level, Fat_level, cocaine_level, cocaethylene_level, virus_level)
    
    OH_level *= rand_range(0.8, 1.2)
    Fat_level *= rand_range(0.8, 1.2)
    
    oh_rate = OH_level / time #per sec
    fat_rate = Fat_level / time
    
    print("new event, state is ", get_node("..").current_state)
    print(text)

func _process(delta):
    
    if OH_level > 0 and randf() < oh_rate * delta :
        emit_particule('OH', packed_particules['OH'])
        OH_level -= 1
        
    if Fat_level > 0 and randf() < fat_rate * delta :
        emit_particule('Fat', packed_particules['Fat'])
        Fat_level -= 1
    
    if time_since_beg > time:
        get_node("..").next_level()
        time_since_beg = -1000
    
    time_since_beg += delta
    
func emit_particule(particular_type, packed_particule):
    var x = rand_range(800, 1500)
    var a = rand_range(-PI, PI)
    var s = rand_range(100, 120)
    
    for child in particules_node_base.get_children():
        if "Cellule" in child.name:
            var particule = packed_particule.instance()
            particule.set_global_position(Vector2(0.0, x).rotated(a))
            particule.apply_impulse(Vector2(), - Vector2(0.0, s).rotated(a))
            particule.set_global_rotation(a)
            child.add_child(particule)
