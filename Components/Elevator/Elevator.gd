extends Node2D


onready var start_pos = get_parent().position

#Elevator Bug: Putting 0 in heigh won't do anything
func run_code(data=null):
#	if tw.is_running():
#		tw.stop()
	if data:
		print(data.height)
		var tw = get_tree().create_tween()
		tw.tween_property(get_parent(), "position:y", start_pos.y+data.height, 2)
		
