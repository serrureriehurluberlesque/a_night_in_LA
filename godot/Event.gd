extends Node2D

#this will be different
export var Fat_level = 0
export var OH_level = 0
export var cocaine_level = 0
export var cocaethylene_level = 0
export var virus_level = 0
#------

#this should always be the same
export var time_1 = 2
export var time_2 = 10
export var time_3 = 120
#------

export var time = 60.0

export var particules_path = "../Cellule"
onready var particules_node = get_node(particules_path)
onready var packed_particule = {'OH' : load("res://OH.tscn"),
								'Particule' : load("res://Particule.tscn"),
								'Fat' : load("res://Fat.tscn")}

								

var time_since_beg = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("../Cellule").set_level(OH_level, Fat_level, cocaine_level, cocaethylene_level, virus_level)
	
	#var da = 2 * PI / Fat_level
	
	OH_level *= rand_range(0.8, 1.2)
	Fat_level *= rand_range(0.8, 1.2)
	
	print("new event, state is ", get_node("..").current_state)

func _process(delta):
	
	var oh_rate = 60.0*delta #per sec
	var fat_rate = 10.0*delta
	
	var current_state = get_node("..").getState()
	
	#state after state
	if current_state == 'just_arrived' :
		#emit shit
		if OH_level > 0 and randf() < oh_rate :
			emit_particule('OH', packed_particule['OH'])
			OH_level -= 1
		
		#next level if it's about time
		if time_since_beg > time_1 :
			get_node("..").next_level()
			get_node("..").current_state = 'binge_eating_1'
			print("then a freakin burger")
			
		#state after state
	elif current_state == 'binge_eating_1' :
		#emit shit
		if Fat_level > 0 and randf() < fat_rate :
			emit_particule('Fat', packed_particule['Fat'])
			Fat_level -= 1
		
		#next level if it's about time
		if time_since_beg > time_2 :
			get_node("..").next_level()
			get_node("..").current_state = 'binge_drinking_1'
			print("glouglouglou")

	elif current_state == 'binge_drinking_1' :
		if OH_level > 0 and randf() < oh_rate :
			emit_particule('OH', packed_particule['OH'])
			OH_level -= 1
		
		if time_since_beg > time_3 :
			get_node("..").next_level()
			get_node("..").current_state = 'binge_cocaining'
	
	time_since_beg += delta
	
func emit_particule(particular_type, packed_particule):
	var x = rand_range(800, 1500)
	var a = rand_range(-PI, PI)
	var s = rand_range(200, 600)	
	
	var particule = packed_particule.instance()
	particule.set_global_position(particules_node.get_global_position() + Vector2(0.0, x).rotated(a))
	particule.apply_impulse(Vector2(), - Vector2(0.0, s).rotated(a))
	particule.set_global_rotation(a)
	particules_node.add_child(particule)
