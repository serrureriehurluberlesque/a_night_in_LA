extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
export var paroi_size = 32

export var DNApath = 'DNA'

#basal rates and shit
export var translation_rate = 0
export var degradation_rate = 1
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
func _physics_process(delta):

        #le peouze et tout ce qui va avec
	#wall_repair_rate = getNode(DNApath).getPosition() == 'Wall_repair'
	#DNA_repair_rate = getNode(DNApath).getPosition() == 'DNA_repair'
	#translation_rate = getNode(DNApath).getPosition() == 'Enzymes'

	apoptosis = (2*DNA_damage + wall_damage + stress_level) / 300

	wall_damage += stress_level / 100 - wall_repair_rate*20
	DNA_damage += stress_level / 100 - DNA_repair_rate*10

	stress_level += fat_level + 2*OH_level + 2*cocaine_level + 4*cocaethylene_level + 5*virus_level

	#simple
	fat_level -= enzymes / 5
	OH_level -= enzymes / 10
	cocaine_level -= enzymes / 2
	cocaethylene_level -= enzymes / 10

	enzymes += 2*translation_rate - degradation_rate

	#later
	#virus_level -= immune_defense
	#immune_defense += 
	
	#more realistic
	#fat_level -= lipid_breakdown_enzymes
	#OH_level -= alcohol_DH
	#cocaine_level -= BCHE
	#cocaethylene_level -= Carboxylesterases
