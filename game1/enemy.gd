extends CharacterBody2D

var player_ref: CharacterBody2D = null
var attkdistance:float=60
var vida:int =2
var morto:bool=false
const attkarea:PackedScene =  preload("res://enemiattk.tscn")
@export var speed:float = 100
@onready var text:Sprite2D = get_node("texture")
@onready var hit:AnimationPlayer = get_node("hit")
@onready var anim:AnimationPlayer = get_node("animate")
func _physics_process(_delta: float)->void:
	if morto:
		return
	if player_ref == null or player_ref.morto:
		velocity=Vector2.ZERO
		animation()
		return
	var direction: Vector2 = global_position.direction_to(player_ref.global_position)
	var distance :float=global_position.distance_to(player_ref.global_position)
	
	if distance < attkdistance:
		anim.play("atk")
		return
	velocity = direction*speed
	move_and_slide()
	animation()	
func spawn_atk()->void:
	var attkareatt = attkarea.instantiate()
	attkareatt.position = Vector2(0,31)
	add_child(attkareatt)
	
func animation()->void:
	if velocity.x<0:
		text.flip_h=true
	if velocity.x>0:
		text.flip_h=false
	if velocity!=Vector2.ZERO:
		anim.play("run")
		return
	anim.play("stay")
		
		
func _on_detection_body_entered(body):
	player_ref = body


func _on_detection_body_exited(_body):
	player_ref = null
func update_health(value : int) ->void:
	vida-=value
	if vida <= 0:
		morto=true
		anim.play("death")
		#coliatk.set_deferred("disabled",true)
		return
	hit.play("hit")


func _on_animate_animation_finished(anim_name: String)->void:
	match anim_name:
		"death":
			get_tree().call_group("lvl","kill_counter")
			queue_free()
	
