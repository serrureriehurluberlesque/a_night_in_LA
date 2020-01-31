extends Node2D


export var OH_level = 0
export var fat_level = 0
export var cocaine_level = 0
export var cocaethylene_level = 0
export var virus_level = 0

export var time = 60.0

export var particules_path = "../Cellule"
onready var particules_node = get_node(particules_path)
onready var packed_particule = load("res://Particule.tscn")
var chance_to_particule = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("../Cellule").set_level(OH_level, fat_level, cocaine_level, cocaethylene_level, virus_level)
    
    var da = 2 * PI / fat_level

func _process(delta):
    chance_to_particule += delta * fat_level
    if chance_to_particule > 1:
        emit_particule()
        chance_to_particule -= 1

func emit_particule():
    var x = rand_range(800, 1500)
    var a = rand_range(-PI, PI)
    var s = rand_range(200, 600)
    
    var particule = packed_particule.instance()
    particule.set_global_position(particules_node.get_global_position() + Vector2(0.0, x).rotated(a))
    particule.apply_impulse(Vector2(), - Vector2(0.0, s).rotated(a))
    particule.set_global_rotation(a)
    particules_node.add_child(particule)
