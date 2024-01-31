extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button.name))

func on_button_pressed(button_name:String):
	match button_name:
		"Newgame":
			Transition.scene_patch="res://level.tscn"
			Transition.fade_in()
		"Quit":
			Transition.can_quit=true
			Transition.fade_in()
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
