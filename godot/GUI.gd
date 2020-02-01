extends ReferenceRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	adjust_sliders()
	
	check_text()


func adjust_sliders() :
	
	var wall_repair_rate = get_node("../Cellule").wall_repair_rate
	var dna_repair_rate = get_node("../Cellule").wall_repair_rate
	var enzymes_rate = get_node("../Cellule").enzymes	
	
	var apoptosis = get_node("../Cellule").apoptosis
	var wall_damage_level = get_node("../Cellule").wall_damage
	var dna_damage_level = get_node("../Cellule").DNA_damage
	var stress_level = get_node("../Cellule").stress_level
	
	print(wall_damage_level)
	
	#no idea if this works
	get_node("Slider_wall").set_ticks(wall_repair_rate)
	get_node("Slider_DNA").set_ticks(dna_repair_rate)
	get_node("Slider_enzymes").set_ticks(enzymes_rate)
	
	get_node("Apoptosis_level").set_value(apoptosis)
	get_node("Wall_damage_level").set_value(wall_damage_level)	
	get_node("Stress_level").set_value(stress_level)
	get_node("DNA_damage_level").set_value(dna_damage_level)
	
func check_text() :
	pass
