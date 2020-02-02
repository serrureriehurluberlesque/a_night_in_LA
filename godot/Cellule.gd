extends StaticBody2D

export var DNApath = 'DNA'

#basal rates and shit
export var translation_rate = 1
export var degradation_rate = 2
var wall_repair_rate = 0
var dna_repair_rate = 0
var enzymes = 0
var recycler_rate = 0

#apoptosis 
export var apoptosis = 0

#all the shit in the cell that's bad
export var stress_level = 0
export var DNA_damage = 0
export var wall_damage = 0

#external factors
var OH_level = 0
var fat_level = 0
var cocaine_level = 0
var cocaethylene_level = 0
var HIV_level = 0
var paracetamol_level = 0
var CE_level = 0
var dechet_level = 0
var enzyme_level = 0

var hp = 10

onready var text = get_node("RichTextLabel")

func get_fat():
    return fat_level

func get_OH():
    return OH_level

func get_cocaine():
    return cocaine_level
    
func get_paracetamol() :
    return paracetamol_level
    
func get_CE() :
    return CE_level

func get_dna_damage() :
    return DNA_damage
    
func get_stress_level() :
    return stress_level

func calculate_dna_damage() :
    var tot_hp = 0
    var max_hp = 0
    
    for child in get_node("Noyau/DNAs").get_children() :
        tot_hp += child.hp
        max_hp += child.max_hp
    
    return 100*(1 - (tot_hp / max_hp))
    
func calculate_wall_damage() :
    var tot_hp = 0
    var max_hp = 0
    
    for child in get_node("parois").get_children() :
        tot_hp += child.hp
        max_hp += child.max_hp
    
    return 100*(1 - (tot_hp / max_hp))
    
func calculate_fat_level() :
    return get_node("particulator").get_part_number(1)
    
func calculate_OH_level() :
    return get_node("particulator").get_part_number(2)
    
func calculate_Coke_level() :
    return get_node("particulator").get_part_number(3)
    
func calculate_HIV_level() :
    return get_node("particulator").get_part_number(4)
    
func calculate_dechet_level() :
    return get_node("particulator").get_part_number(5)
    
func calculate_paracetamol_level() :
    return get_node("particulator").get_part_number(6)
    
func calculate_CE_level() :
    return get_node("particulator").get_part_number(7)

func calcuate_enzyme_level():
    return get_node("enzymator").get_number_enzyme()
        
func get_wall_damage() :
    return wall_damage
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):

    apoptosis = (2*DNA_damage + wall_damage + stress_level) / 2

    wall_damage = calculate_wall_damage()
    
    DNA_damage = calculate_dna_damage()
    
    #simple
    fat_level = calculate_fat_level()
    OH_level = calculate_OH_level()
    cocaine_level = calculate_Coke_level()
    HIV_level = calculate_HIV_level()
    dechet_level = calculate_dechet_level()
    paracetamol_level = calculate_paracetamol_level()
    enzyme_level = calcuate_enzyme_level()

    stress_level = fat_level + 2*OH_level + 2*cocaine_level + 3*HIV_level + dechet_level + enzyme_level / 2  # + 4*cocaethylene_level 
    
    text.text = ""
    var stats = ["fat_level", "OH_level", "cocaine_level", "stress_level", "wall_damage", "DNA_damage", "apoptosis", "enzymes"]
    for stat in stats:
        text.text += stat + ": " + str(get(stat)) + "\n"
