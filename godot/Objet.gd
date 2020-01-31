extends RigidBody2D


export var hp = 100

export var path_ref = ".."

onready var ref = get_node(path_ref)


# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("PinJoint2D").set_node_b(ref.get_path())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
