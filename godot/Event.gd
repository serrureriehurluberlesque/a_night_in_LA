extends Node2D


export var graisse_number = 1
export var alcohol_number = 1

export var time = 60.0

# Called when the node enters the scene tree for the first time.
func _ready():
    print("atttention il y a " + str(graisse_number) + " trucs de graisse et " + str(alcohol_number) + " trucs d'alcool.")
