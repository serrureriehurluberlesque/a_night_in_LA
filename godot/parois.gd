extends Node2D


export var paroi_size = 61

var cell_size = 256.0
var variation = 10.0

func _ready():
	var packed_paroi = load("res://Paroi.tscn")
	var da = 2 * PI / paroi_size
	
	for i in range(paroi_size):
		var paroi = packed_paroi.instance()
		var size = cell_size + variation * cos(da * i * 3)
		var a = da * i + rand_range(-variation, variation) / 130.0
		paroi.set_global_position(get_global_position() + Vector2(0.0, size).rotated(da * i))
		paroi.set_global_rotation(a)
		paroi.name = str(i)
		
		add_child(paroi)
