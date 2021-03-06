extends Node2D

export var actual_level = 0
var actual_level_node
var perdu = false
var loading = false
var packed_scene 
var init = true

export var current_state = 'just_arrived'

onready var j_sprites = {}

var loose_image = {}

var loose_i = 0

func _ready():
    
    get_node("AudioStreamPlayer").play()
    
    for i in range(10):
        j_sprites[i] = load("res://sprites/Story/Story_" + str(i) + ".png")
        
    j_sprites[10] = load("res://sprites/Story/Story_10.png")
    j_sprites[11] = load("res://sprites/Story/Story_11.png")
    j_sprites[12] = load("res://sprites/Story/Story_12.png")
        
    for i in range(13):
        loose_image[i] = load("res://sprites/Animations/Apostasie/0" + str((i+1)/10) + str((i+1)%10) + ".png")
    loose_image[13] = load("res://sprites/Game_over.png")
    packed_scene = load("res://Event" + str(actual_level) + ".tscn")
    next_level()    
    
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
#        if init:
#            init = false
#            get_node("Histoire/AnimationPlayer").seek(actual_level_node.time_absolu)
    add_child(actual_level_node)

    actual_level = actual_level + 1

    yield(get_tree().create_timer(1.0), "timeout")
    call_deferred("preload_scene")
    loading = false

func preload_scene():
    packed_scene = load("res://Event" + str(actual_level) + ".tscn")

func _process(_delta):
    if not perdu and get_node("Cellule").hp <= 0:
        loose()
    if get_node("Cellule").apoptosis >= 100:
        get_node("Cellule").hp -= 1

func j_sprite(i):
    get_node("j").texture = j_sprites[i]
    
func win():
    config.loose = false
    get_tree().change_scene("res://End.tscn")

func loose():
    config.loose = true
    get_tree().change_scene("res://End.tscn")

func set_loose():
    get_node("Loose").texture = loose_image[loose_i]
    loose_i += 1

func set_win():
    get_node("Win").texture = load("res://sprites/Background_new.png")
