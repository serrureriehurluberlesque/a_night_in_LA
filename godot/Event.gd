extends Node2D


export var OH_level = 0
export var fat_level = 0
export var cocaine_level = 0
export var cocaethylene_level = 0
export var virus_level = 0

export var time = 60.0

# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("../Cellule").set_level(OH_level, fat_level, cocaine_level, cocaethylene_level, virus_level)
    
    print("Nouvel Event.")
