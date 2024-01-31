extends Node2D

var kill_count:int =0
@export var target_kill:int
@export var next_lvl:String
@export var current_lvl:String

func _ready():
	Transition.scene_patch=current_lvl
	
func kill_counter():
	kill_count+=1
	if kill_count == target_kill:
		Transition.scene_patch=next_lvl
		Transition.fade_in(true)
