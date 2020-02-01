extends StaticBody2D

export var DNApath = 'DNA'

#basal rates and shit
export var translation_rate = 1
export var degradation_rate = 2
export var wall_repair_rate = 0
export var DNA_repair_rate = 0
export var enzymes = 0

#apoptosis 
export var apoptosis = 0

#all the shit in the cell that's bad
export var stress_level = 0
export var DNA_damage = 0
export var wall_damage = 0

#external factors
export var OH_level = 0
export var fat_level = 0
export var cocaine_level = 0
export var cocaethylene_level = 0
export var virus_level = 0

var hp = 10

onready var text = get_node("RichTextLabel")

func set_level(a, b, c, d, e):
	var OH_level = a
	var fat_level = b
	var cocaine_level = c
	var cocaethylene_level = d
	var virus_level = e

func get_fat():
	return fat_level

func get_OH():
	return OH_level

func get_cocaine():
	return cocaine_level

func get_dna_damage() :
	return DNA_damage

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
		
func get_wall_damage() :
	return wall_damage
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

		#le peouze et tout ce qui va avec
	#wall_repair_rate = getNode(DNApath).is_activated()
	#DNA_repair_rate = getNode(DNApath).is_activated()
	#translation_rate = getNode(DNApath).is_activated()

	apoptosis = (2*DNA_damage + wall_damage + stress_level)

	wall_damage = calculate_wall_damage()
	
	DNA_damage = calculate_dna_damage()
	
	#simple
	fat_level = calculate_fat_level()
	OH_level = calculate_OH_level()

	stress_level = fat_level + 2*OH_level # + 2*cocaine_level + 4*cocaethylene_level + 5*virus_level
	
	text.text = ""
	var stats = ["fat_level", "OH_level", "cocaine_level", "stress_level", "wall_damage", "DNA_damage", "apoptosis", "enzymes"]
	for stat in stats:
		text.text += stat + ": " + str(get(stat)) + "\n"
		
	#later
	#virus_level -= immune_defense
	#immune_defense += 
	
	#more realistic
	#fat_level -= lipid_breakdown_enzymes
	#OH_level -= alcohol_DH
	#cocaine_level -= BCHE
	#cocaethylene_level -= Carboxylesterases
