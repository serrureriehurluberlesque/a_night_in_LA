extends RigidBody2D
class_name Objet


export var hp = 100

func damage(n):
    hp -= n
    modulate

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
