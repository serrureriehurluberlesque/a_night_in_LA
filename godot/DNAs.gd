extends Node2D

export var dna_number = 4
var activated_dna = 4
var stock = 0

export var dna_cost = 2
export var wall_cost = 1
export var enzymes_cost = 1

export var increment_value = 1

func _ready():
	var packed_dna = load("res://DNA.tscn")
	var da = 2 * PI / dna_number
	
	for i in range(dna_number):
		var dna = packed_dna.instance()
		dna.indice = i
		add_child(dna)
		dna.set_global_position(get_global_position() + Vector2(0.0, 46.0).rotated(da * i))
		dna.pin(get_node("../.."))

func activate(n): 	#= increment
	increment(n)
	activated_dna = n
		
func increment(i) :
	
	var r = increment_value
	
	if i == 0: #DNA
		repair(r * 30 * wall_cost * enzymes_cost)
		
		get_node("../../parois").repair(-r * dna_cost * enzymes_cost) #change rate of production of particles
		get_node("../../enzymator").boost(-r * dna_cost * wall_cost) #change rate of production too
		
	elif i == 1: #Wall
		get_node("../../parois").repair(r * 10 * dna_cost * enzymes_cost)
		
		get_node("../../enzymator").boost(-r * dna_cost * wall_cost)
		repair(-r * 30 * wall_cost * enzymes_cost)
		
	elif i == 2: #Enzymes
		get_node("../../enzymator").boost(r * dna_cost * wall_cost)
		
		repair(-r * 30 * wall_cost * enzymes_cost)		
		get_node("../../parois").repair(-r * dna_cost * enzymes_cost)
	elif i == 3: #useless so far
		stock += r

func set_prod(a, b, c):
		var r = 1
		repair(a * 30 * wall_cost * enzymes_cost)
		
		get_node("../../parois").repair(-r * dna_cost * enzymes_cost) #change rate of production of particles
		get_node("../../enzymator").boost(-r * dna_cost * wall_cost) #change rate of production too

func repair(f):
	for child in get_children():
		child.repair(f)
		
func _physics_process(delta):
	action(delta, activated_dna)
	
func action(delta, i):
	stock *= 0.97
	var value = delta + 0.02 * stock
	
	if i == 0:
		repair(value * 30)
	elif i == 1:
		get_node("../../parois").repair(value * 10)
	elif i == 2:
		get_node("../../enzymator").boost(value)
	elif i == 3:
		stock += value

func dna_die(i):
#    print("death")
#    print(i)
	if i == 1:
		pass
