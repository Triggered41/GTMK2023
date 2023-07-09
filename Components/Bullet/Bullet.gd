extends Area2D


var speed = 5.0

func _physics_process(delta):
	position += transform.x*speed
	
func _on_Bullet_body_entered(body: Node):
	if body.has_method("damage"):
		body.damage()


func _on_VisibilityNotifier2D_screen_exited():
	print("OK")
	queue_free()
