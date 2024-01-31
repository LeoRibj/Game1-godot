extends CanvasLayer


@onready var anim:AnimationPlayer=get_node("AnimationPlayer")
var scene_patch:String =""
var can_quit:bool=false
func fade_in(opt:bool=false):
	if opt:
		anim.play("lvl")
		return
	anim.play("claro")



func _on_animation_player_animation_finished(anim_name):
	if anim_name=="claro":
		if can_quit:
			get_tree().quit()
			return
		get_tree().change_scene_to_file(scene_patch)
		anim.play("escure")
	if anim_name=="lvl":
		get_tree().change_scene_to_file(scene_patch)
		anim.play("escure")
