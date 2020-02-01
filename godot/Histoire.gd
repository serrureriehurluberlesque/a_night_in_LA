extends ReferenceRect


onready var txtlabel = get_node("RichTextLabel")


# Called when the node enters the scene tree for the first time.
func _ready():
    
    txtlabel.push_color("red")
    txtlabel.append_bbcode("This is Lucy." \
                            + "Lucy is a human cell, inhabiting J***'s liver." \
                            + "She could have led a long and happy life. " \
                            + "But J*** is going to Las Vegas. " \
                            + "Try to help her as best as you can." \
                            + "Lucy's fate will be akin to every cell's in J***'s body. "\
                            + "But for now... ...we only care about her. ")
    txtlabel.pop()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

