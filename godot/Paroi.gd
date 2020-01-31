extends Objet


var wall_health = 100 #btwn 0-100
export var path_ref = ".."

onready var ref = get_node(path_ref)


# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("PinJoint2D").set_node_b(ref.get_path())


func _physics_process(delta) :

    #wall_health -= getNode(Cell).get_dna_damage()
    #wall_health = min(max(dna_health, 0), 100)


    pass



