extends Node

var loose = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.



func _input(event):
    if event.is_pressed() and event.is_action("quit"):
        get_tree().quit()
