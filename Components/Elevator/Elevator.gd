extends Node2D


onready var start_pos = get_parent().position

#Elevator Bug: Putting 0 in heigh won't do anything
func run_code(data=null):
	var new_dir = Vector2.ZERO
	
	if data.has("positionX"):
		new_dir.x = float(data["positionX"])
	if data.has("positionY"):
		new_dir.y = float(data["positionY"])
		
	var tw = get_tree().create_tween()
	tw.tween_property(get_parent(), "position", start_pos+new_dir, 2)
		
