extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var dna_number = 4

# Called when the node enters the scene tree for the first time.
func _ready():
    var packed_dna = load("res://DNA.tscn")
    var da = 2 * PI / dna_number
    
    for i in range(dna_number):
        var dna = packed_dna.instance()
        dna.set_global_position(get_global_position() + Vector2(0.0, 16.0).rotated(da * i))
        add_child(dna)
        print("dna créée")
