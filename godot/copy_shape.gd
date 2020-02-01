extends CollisionShape2D

export var shape_path = "../../../CollisionShape2D"
onready var shape_node = get_node(shape_path)

# Called when the node enters the scene tree for the first time.
func _ready():
    pass  # shape = shape_node.shape  # .duplicate(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
