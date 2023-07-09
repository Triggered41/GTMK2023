extends TextEdit

onready var button = $RunButton

var object = null
var lines = 0

export(Vector2) var valid_lines
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	lines = get_line_count()
	add_keyword_color("var", Color("FF8888"))
	
	add_keyword_color("False", Color("8888BB"))
	add_keyword_color("True", Color("8888BB"))
	
	add_color_region('"', '"', Color("AAAA22"))
	add_color_region('#', '', Color("00AA00"), true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextEdit_text_changed():
#	Prevent from changin number of lines
	if get_line_count()!=lines:
		undo()
	else:
		if object != null:
			object.set_code(text)

func _on_TextEdit_cursor_changed():
	if cursor_get_line()>=valid_lines.x and cursor_get_line()<=valid_lines.y:
		readonly = false
	else:
		readonly = true
	pass


func _on_Area2D_body_entered(body:Node):
	if body.has_method("get_code"):
		print("Found")
		body.connect("runnable", self, "can_run")
		object = body
		text = body.code
		lines = len(text.split("\n"))
		valid_lines = body.valid_lines
		readonly = false

func _on_Area2D_body_exited(body:Node):
#	if body == object:
#		object = null
#		body.disconnect("runnable", self, "can_run")
	pass

var data
func can_run(can, new_data):
	button.disabled = !can
	data = new_data

func _on_RunButton_button_down():
	if object != null:
		hide()
		object.run_code(data)
