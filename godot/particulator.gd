extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func get_part_number(i):  # i = 0 -> all particule
    var n = 0
    for body in get_overlapping_bodies():
        if body.particule and (i == 0 or body.type == i):
            n += 1
            
    return n
    
func set_goal(global_position, r):
    for child in get_children():
        #if child is HIV
            #set target as get_target_nucleus()
            pass

