extends Node2D

var loose_image = {}

var loose_i = 0


# Called when the node enters the scene tree for the first time.
func _ready():
 
    for i in range(13):
        loose_image[i] = load("res://sprites/Animations/Apostasie/0" + str((i+1)/10) + str((i+1)%10) + ".png")
    loose_image[13] = load("res://sprites/Game_over.png")
 
    if not config.loose :
        get_node("Win").show()
        loose_image[13] = load("res://sprites/Victory_2.png")
        get_node("Loose/Anim").play("Win")
    
    else :
        get_node("Loose").show()
        get_node("Loose/Anim").play("Loose")

func _input(event):
    
    if event.is_pressed():
        get_tree().quit()
        
func loose():
    get_node("Loose").show()
    get_node("Cellule").hide()
    get_node("Loose/Anim").play("Loose")
func set_loose():
    get_node("Loose").texture = loose_image[loose_i]
    loose_i += 1

func set_win():
    get_node("Win").texture = load("res://sprites/Background_new.png")
