extends Objet


var wall_health = 100 #btwn 0-100
export var path_ref = "../.."

onready var ref = get_node(path_ref)

onready var default_collision_mask = get_collision_mask()

# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("PinJoint2D").set_node_b(ref.get_path())


func _physics_process(delta) :
    if hp < 0.0:
        set_collision_layer(0)
    else:
        default_collision_mask



