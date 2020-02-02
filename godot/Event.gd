extends Node2D

export var Fat_level = 0
export var OH_level = 0
export var Coke_level = 0
export var cocaethylene_level = 0
export var HIV_level = 0

var oh_rate
var fat_rate
var Coke_rate
var HIV_rate

export var time = 60.0
export var time_chill = 0.0
export var time_absolu = 60.0
export var text = "And the next level"

export var particules_path = ".."
onready var particules_node_base = get_node(particules_path)
onready var packed_particules = {'OH' : load("res://OH.tscn"),
    'Particule' : load("res://Particule.tscn"),
    'Coke' : load("res://Coke.tscn"),
    'HIV' : load("res://HIV.tscn"),
    'Fat' : load("res://Fat.tscn")}

var time_since_beg = 0
var actual_sprite

var string_to_sprite = {'drink1':1, 'eat':2, 'drink2':3, 'nap':4, 'coke':5, 'pill':6, 'sex':7}

# Called when the node enters the scene tree for the first time.
func _ready():
    OH_level *= rand_range(0.8, 1.2)
    Fat_level *= rand_range(0.8, 1.2)
    Coke_level *= rand_range(0.8, 1.2)
    HIV_level *= rand_range(0.8, 1.2)
    
    oh_rate = OH_level / time #per sec
    fat_rate = Fat_level / time
    Coke_rate = Coke_level / time #per sec
    HIV_rate = HIV_level / time
    
    set_sprite(choose_sprite())
    
    
    print("new event, state is ", get_node("..").current_state)
    print(text)

func _process(delta):
    
    if OH_level > 0 and randf() < oh_rate * delta :
        emit_particule('OH', packed_particules['OH'])
        OH_level -= 1
        
    if Fat_level > 0 and randf() < fat_rate * delta :
        emit_particule('Fat', packed_particules['Fat'])
        Fat_level -= 1
        
    if Coke_level > 0 and randf() < Coke_rate * delta :
        emit_particule('Coke', packed_particules['Coke'])
        Coke_level -= 1
        
    if HIV_level > 0 and randf() < HIV_rate * delta :
        emit_particule('HIV', packed_particules['HIV'])
        HIV_level -= 1
    
    if time_since_beg > time + time_chill:
        get_node("..").next_level()
        time_since_beg = -1000
    
    time_since_beg += delta
    
    var new_sprite = choose_sprite()
    if actual_sprite != new_sprite:
        set_sprite(new_sprite)
        actual_sprite = new_sprite
    
func emit_particule(_particular_type, packed_particule):
    var x = rand_range(800, 1500)
    var a = rand_range(-PI, PI)
    var s = rand_range(100, 120)
    
    for child in particules_node_base.get_children():
        if "Cellule" in child.name:
            var particule = packed_particule.instance()
            particule.set_global_position(Vector2(0.0, x).rotated(a))
            particule.apply_impulse(Vector2(), - Vector2(0.0, s).rotated(a+rand_range(-PI/16, PI/16)))
            particule.set_global_rotation(a)
            child.add_child(particule)

func choose_sprite():
    var i = 0
    var current_state = get_node("..").actual_level
    
    if current_state == 2 :
        i = string_to_sprite['drink1']
    elif current_state == 3 :
        i = string_to_sprite['eat']
    elif current_state == 4 :
        i = string_to_sprite['drink2']
    elif current_state == 5 :
        i = string_to_sprite['nap']
    elif current_state == 6 :
        i = string_to_sprite['drink2']
    elif current_state == 7 :
        i = string_to_sprite['coke']
    elif current_state == 8 :
        i = string_to_sprite['sex']
    elif current_state == 9 :
        i = string_to_sprite['pill']
    
    return i
    
func set_sprite(i):
    get_node("..").j_sprite(i)
