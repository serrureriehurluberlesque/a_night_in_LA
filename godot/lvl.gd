extends Node2D

export var actual_level = 1
var actual_level_node
var perdu = false
var loading = false
var packed_scene 

export var current_state = 'just_arrived'
	
func _ready():
	packed_scene = load("res://Event" + str(actual_level) + ".tscn")
	next_level()

func getState() :
	return current_state
	
func next_level():
	if not loading:
		loading = true
		call_deferred("load_scene")

func load_scene():
	if actual_level > 1 and actual_level_node:
		actual_level_node.queue_free()
	if not packed_scene:
		win()
		return
	else:
		actual_level_node = packed_scene.instance()
	add_child(actual_level_node)

	actual_level = actual_level + 1

	yield(get_tree().create_timer(1.0), "timeout")
	call_deferred("preload_scene")
	loading = false

func preload_scene():
	packed_scene = load("res://Event" + str(actual_level) + ".tscn")

func _process(delta):
	if not perdu and get_node("Cellule").hp <= 0:
		get_node("joueur").die()
		loose()

func win():
	pass
#    get_node("joueur/Camera2D/Win").show()

func loose():
#    get_node("joueur/Camera2D/Win").hide()
#    get_node("joueur/Camera2D/Loose").show()
	perdu = true
