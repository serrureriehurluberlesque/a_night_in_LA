extends Node2D

export var paroi_size = 61

export var cell_size = 356.0
var variation = 60.0

export var stress_amplificator = 1.05

func _ready():
    var packed_paroi = load("res://Paroi.tscn")
    var da = 2.0 * PI / paroi_size
    
    for i in range(paroi_size):
        var paroi = packed_paroi.instance()
        var size = cell_size + variation * -(cos(da * i) *(cos(da * i)))
        var a = da * i + 0.2 * cos(2 * (da * i + PI / 4)) + rand_range(-variation, variation) / 1730.0 # a adapter selon la forme
        paroi.set_global_position(Vector2(0.0, size).rotated(da * i))
        paroi.set_global_rotation(a)
        paroi.name = str(i)
        
        add_child(paroi)

func repair(f):
    for child in get_children():
        child.repair(f)
