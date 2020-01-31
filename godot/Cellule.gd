extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
export var paroi_size = 32

#all the shit in the cell that's bad
export var stress_level = 0
export var 


# Called when the node enters the scene tree for the first time.
func _ready():
    var packed_paroi = load("res://Paroi.tscn")
    var da = 2 * PI / paroi_size
    
    for i in range(paroi_size):
        var paroi = packed_paroi.instance()
        paroi.set_global_position(get_global_position() + Vector2(0.0, 256.0).rotated(da * i))
        paroi.set_global_rotation(da * i)
        add_child(paroi)
        print("paroi créée")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
