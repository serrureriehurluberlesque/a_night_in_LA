extends Node2D

export var dna_number = 4
var activated_dna = 4
var stock = 0
var continuous_repair = 0.0

export var dna_cost = 2
export var wall_cost = 1
export var enzymes_cost = 1

export var increment_value = 1.0

var n_adn = 4
var value = {}

func _ready():
    for i in range(n_adn):
        value[i] = 5.0
	
        var packed_dna = load("res://DNA.tscn")
        var da = 2 * PI / dna_number

        for i in range(dna_number):
            var dna = packed_dna.instance()
            dna.indice = i
            variate_sprite(dna.get_node("Sprite"), "res://sprites/ADN/ADN_" + str(i%2 + 1) + ".png")
            variate_sprite(dna.get_node("lettre"), "res://sprites/Good guys/" + str(i) + ".png")
            add_child(dna)
            dna.set_global_position(get_global_position() + Vector2(0.0, 46.0).rotated(da * i))
            dna.pin(get_node("../.."))
	
func variate_sprite(node, ressource):
    var img = Image.new()
    var itex = ImageTexture.new()
    img.load(ressource)
    itex.create_from_image(img)
    node.texture = itex

func activate(n): 	#= increment
    increment(n)
    activated_dna = n
		
func increment(i) :
    var at = 0
    for j in range(n_adn):
        at += abs(value[j])
    
    var r = at / 20.0 + 0.5
    for j in range(n_adn):
        var d
        if i == j:
            d = r
        else:
            d = - r / (n_adn - 1)
        value[j] += d

    set_prod(value)

func set_prod(dict):
    var total = 0
    for i in range(n_adn):
        total += abs(dict[i])
    
    var dict_clean = {}
    for i in range(n_adn):
        dict_clean[i] = dict[i] / total
    
    set_continous_repair(dict_clean[0])
    
    get_node("../..").dna_repair_rate = dict_clean[0]
    get_node("../..").wall_repair_rate = dict_clean[2]
    get_node("../..").enzymes = dict_clean[1]
    
    get_node("../../enzymator").set_prod({0: dict_clean[1], 1: dict_clean[2]})

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
