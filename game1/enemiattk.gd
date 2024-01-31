extends Area2D
@export var damage:int=1


func _on_body_entered(body)->void:
	body.update_health(damage) # Replace with function body.


func _on_timer_timeout():
	queue_free() # Replace with function body.
