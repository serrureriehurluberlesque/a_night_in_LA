extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tt = 0.0
var t = 0.0
var cps = 115.0
var c = 0
onready var base_text = get_node("../text").bbcode_text

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func _physics_process(delta):
    tt += delta
    t += delta
    if t > 1 / cps:
        t -= 1 / cps
        if c <= base_text.length():
            if base_text[c] == "#":
                print(tt)
                c += 1
            else:
                bbcode_text += base_text[c]
                if base_text[c] == "\n":
                    t -= 1.0
                c += 1
        
