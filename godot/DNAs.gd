extends Node2D

export var dna_number = 4
var activated_dna = 1

func _ready():
    var packed_dna = load("res://DNA.tscn")
    var da = 2 * PI / dna_number
    
    for i in range(dna_number):
        var dna = packed_dna.instance()
        dna.set_global_position(get_global_position() + Vector2(0.0, 46.0).rotated(da * i))
        dna.indice = i
        add_child(dna)

func activate(n):
    deactivate_all()
    activated_dna = n
    
func deactivate_all():
    for child in get_children():
        child.deactivate()
