extends Node2D

export var length = 100.0
export(PackedScene) var bullet:PackedScene
 
onready var ray:RayCast2D = $RayCast2D
onready var timer:Timer = $Timer

var target = "Player" #["PLAYER", "TURRET", "SOLDIER"]

var can_shoot = false

func run_code(data):
	if data.has("target"):
		target = data.target

func _ready():
	ray.set_as_toplevel(true)
	ray.global_position = global_position

func _physics_process(delta):
	attack()
	
	var t = get_tree().get_nodes_in_group(target)[0]
	ray.cast_to = t.global_position - global_position

func attack():
	if get_tree().get_nodes_in_group(target) != []:
		if timer.is_stopped():
			timer.start()

func shoot():
	if can_shoot and ray.is_colliding():
		if ray.get_collider().is_in_group(target):
			var target_obj = get_tree().get_nodes_in_group(target)[0]
			var i = bullet.instance()
			get_tree().root.add_child(i)
			i.global_position = global_position
			i.rotation = (target_obj.global_position - global_position).angle()


func _on_Timer_timeout():
	shoot()


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		can_shoot = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		can_shoot = false

