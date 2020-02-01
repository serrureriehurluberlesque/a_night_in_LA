extends Node2D

export var dna_number = 4
var activated_dna = 1
var stock = 0

func _ready():
    var packed_dna = load("res://DNA.tscn")
    var da = 2 * PI / dna_number
    
    for i in range(dna_number):
        var dna = packed_dna.instance()
        dna.indice = i
        add_child(dna)
        dna.set_global_position(get_global_position() + Vector2(0.0, 46.0).rotated(da * i))
        dna.pin(get_node("../.."))

func activate(n):
    deactivate_all()
    activated_dna = n
    
func deactivate_all():
    for child in get_children():
        child.deactivate()

func repair(f):
    for child in get_children():
        child.repair(f)
        
func _physics_process(delta):
    action(delta, activated_dna)
    
func action(delta, i):
    stock *= 0.97
    var value = delta + 0.02 * stock
    
    if i == 0:
        repair(value * 100)
    elif i == 1:
        get_node("../../parois").repair(value * 100)
    elif i == 2:
        get_node("../../enzymator").boost(value * 100)
    elif i == 3:
        stock += value

func dna_die(i):
    print("death")
    print(i)
    if i == 1:
        pass
    
