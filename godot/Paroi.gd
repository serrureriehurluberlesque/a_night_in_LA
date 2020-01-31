extends Objet


export var path_ref = ".."

onready var ref = get_node(path_ref)


# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("PinJoint2D").set_node_b(ref.get_path())
