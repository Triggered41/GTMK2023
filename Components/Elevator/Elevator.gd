extends Node2D


onready var start_pos: Vector2 = get_parent().position
var off: float
var tw: SceneTreeTween
var pl
var can_move = false

#Elevator Bug: Putting 0 in heigh won't do anything
func run_code(data=null):
	pl = get_tree().get_nodes_in_group("Player")[0] as KinematicBody2D
	var new_dir = Vector2.ZERO
	
	if data.has("positionX"):
		new_dir.x = float(data["positionX"])
	if data.has("positionY"):
		new_dir.y = float(data["positionY"])
		
	tw = get_tree().create_tween()
	tw.tween_property(get_parent(), "position", start_pos+new_dir, 2)
	off = start_pos.distance_to(start_pos+new_dir)
	print("Dist: ", off)
	can_move = true
	yield(tw, "finished")
	can_move = false

func _physics_process(delta):
	if can_move:
#		var off = global_position - pl.global_position
		pl.position.x += (off)/120
