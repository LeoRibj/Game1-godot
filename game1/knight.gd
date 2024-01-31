extends CharacterBody2D
var posso_at = true
var attackat = false
var morto = false
@onready var animation: AnimationPlayer = get_node("Animation")
@export var movspeed: float = 250
@onready var texture:Sprite2D = get_node("texture")
@onready var coliatk:CollisionShape2D = get_node("attackar/colisionatk")
@export var damage: int= 1
@export var vida:int = 4
@onready var hit:AnimationPlayer = get_node("hit")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(_delta) -> void:
	if posso_at == false or morto:
		return
	movie()
	animate()
	attack()
func movie() ->void:
	var direction: Vector2 = get_direction()
	velocity = direction * movspeed
	move_and_slide()
func animate() ->void:
	if velocity.x < 0:
		texture.flip_h = true
		coliatk.position.x = -65
	elif velocity.x>0:
		texture.flip_h = false
		coliatk.position.x = 65
	if velocity!= Vector2.ZERO:
		animation.play("movie")
		return
	animation.play("stop")
func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up","down")
	).normalized()
func attack()->void:
	if Input.is_action_just_pressed("attack") and posso_at:
		posso_at = false
		animation.play("atack")


func _on_animation_animation_finished(anim_name):
	match anim_name:
		"atack":
			posso_at=true # Replace with function body.
		"death":
			Transition.fade_in()


func _on_attackararea_body_entered(body) ->void:
	body.update_health(damage)

func update_health(value : int) ->void:
	vida-=value
	if vida <= 0:
		morto=true
		animation.play("death")
		coliatk.set_deferred("disabled",true)
		return
	hit.play("ht")
