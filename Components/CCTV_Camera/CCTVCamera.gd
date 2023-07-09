extends Node2D

onready var rays = get_node("Rays")
onready var t = $Timer

func _physics_process(delta):
	for i in rays.get_children():
		if i.is_colliding() and i.get_collider().is_in_group("Player"):
			get_tree().reload_current_scene()
#			print("Player")
			

func run_code(data):
	if data.has("focal_length"):
		t.start()
		get_node("Light2D").scale = Vector2.ONE*float(data.focal_length)
		for i in rays.get_children():
			i.cast_to = Vector2.ZERO


func _on_Timer_timeout():
	run_code({"focal_length": 1.0})
