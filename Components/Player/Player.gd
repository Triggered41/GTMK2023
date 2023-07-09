extends KinematicBody2D

onready var code_editor
onready var img = $Icon

var speed = 100
var vel: Vector2

func _ready():
	code_editor = get_node("../CanvasLayer/CodeEditor")
	$Area2D.connect("body_entered", code_editor, "_on_Area2D_body_entered")
	$Area2D.connect("body_exited", code_editor, "_on_Area2D_body_exited")

func _physics_process(delta):
	if Input.is_action_just_released("restart"):
		get_tree().reload_current_scene()
	
	vel.x = Input.get_axis("ui_left", "ui_right")
	if vel.x > 0:
		img.flip_h = false
	elif vel.x < 0:
		img.flip_h = true
	vel.y = 1.0
	vel = move_and_slide(vel*speed)
	
	if Input.is_action_just_released("alt"):
		code_editor.visible = !code_editor.visible
		code_editor.cursor_set_line(code_editor.valid_lines.x)

func damage():
	get_tree().reload_current_scene()
	print("Hit Player")
