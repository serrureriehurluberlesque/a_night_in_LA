extends Node2D


export var Fat_level = 0
export var OH_level = 0
export var cocaine_level = 0
export var cocaethylene_level = 0
export var virus_level = 0

export var time_1 = 10
export var time_2 = 60

export var time = 60.0

export var particules_path = "../Cellule"
onready var particules_node = get_node(particules_path)
onready var packed_particule = {'OH' : load("res://OH.tscn"),
								'Particule' : load("res://Particule.tscn"),
								'Fat' : load("res://Fat.tscn")}

export var current_state = 'just_arrived'
								

var time_since_beg = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("../Cellule").set_level(OH_level, Fat_level, cocaine_level, cocaethylene_level, virus_level)
	
	print("let's go, alcohol first'")
	
	var da = 2 * PI / Fat_level
	
	OH_level += randi() % 20
	Fat_level += randi() % 20

func _process(delta):
	
	print(time_since_beg)
	set_chronological_state()
	
	var oh_rate = .0*delta #per sec
	var fat_rate = 1.0*delta
	
	if current_state == 'just_arrived' and Fat_level > 0 and randf() < fat_rate:
		emit_particule('Fat', packed_particule['Fat'])
		Fat_level -= 1

	if current_state == 'binge_drinking_1' and OH_level > 0 and randf() < oh_rate :
		emit_particule('OH', packed_particule['OH'])
		OH_level -= 1
	
	time_since_beg += delta
	
func set_chronological_state() :
	if time_since_beg < time_1 :
		#print("10 sec past")
		pass
		
	elif time_since_beg < time_2 :
		print("1 min past")
		current_state = 'binge_drinking_1'

func emit_particule(particular_type, packed_particule):
	var x = rand_range(800, 1500)
	var a = rand_range(-PI, PI)
	var s = rand_range(200, 600)	
	
	var particule = packed_particule.instance()
	particule.set_global_position(particules_node.get_global_position() + Vector2(0.0, x).rotated(a))
	particule.apply_impulse(Vector2(), - Vector2(0.0, s).rotated(a))
	particule.set_global_rotation(a)
	particules_node.add_child(particule)
