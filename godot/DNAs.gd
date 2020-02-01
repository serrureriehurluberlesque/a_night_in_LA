extends Node2D

export var dna_number = 4
var activated_dna = 4
var stock = 0
var continuous_repair = 0.0

export var dna_cost = 2
export var wall_cost = 1
export var enzymes_cost = 1

export var increment_value = 1.0

var n = 3
var value = {}

func _ready():
    for i in range(n):
        value[i] = 0.0
    
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
    for j in range(n):
        var d 
        if i == j:
            d = r
        else:
            d = - r / (n - 1)
        value[j] += d

    set_prod(value[0], value[1], value[2]) 

func set_prod(a, b_brut, c_brut):
    set_continous_repair(a)
    
    var t = 5 + max(0, b_brut) + max(0, c_brut)
    var b = max(0, b_brut / t)
    var c = max(0, c_brut / t)
    
    var dict = {}
    dict[0] = 1 - b - c  # gros tas
    dict[1] = b  # soigneur de mur
    dict[2] = c  # soigneur general
    dict[3] = 0  # soigneur d'enzyme
        
    get_node("../../enzymator").set_prod(dict) #change rate of production too
    
    get_node("../..").wall_repair_rate = b_brut
    get_node("../..").dna_repair_rate = a
    get_node("../..").enzymes = c_brut

func set_continous_repair(a):
    continuous_repair = a
    
func repair(f):
	for child in get_children():
		child.repair(f)
		
func _physics_process(delta):
    if continuous_repair > 0.0:
        repair(delta * continuous_repair)
	# action(delta, activated_dna)
    
    
	
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
