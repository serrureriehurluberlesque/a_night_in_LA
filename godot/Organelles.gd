extends Node2D


# Declare member variables here. Examples:
# var a = 2
var offset = {}
var oldd = {}
var v = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
    for child in get_children():
        offset[child.name] = Vector2()
        oldd[child.name] = Vector2(0.02, 0.02)


func _process(delta):
    for child in get_children():
        var d = oldd[child.name].rotated(rand_range(-delta,delta) * v) - offset[child.name] / v / 100.0
        if d.length() < 0.01:
            d += Vector2(0.02, 0.02)
        offset[child.name] += d
        oldd[child.name] = d
        child.set_global_position(child.get_global_position() + d)
