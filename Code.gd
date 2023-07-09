extends Node2D

signal runnable(can_run, data)

export var valid_lines:Vector2

export(String, MULTILINE) var code:String
export(Dictionary) var answers

func get_code():
	return code

func set_code(new_code):
	code = new_code
	
	var data:Dictionary = {}
	var check = false
	
	var a = code.split("\n")
	for i in answers:
		for j in a:
			if i + " = " + str(answers[i]) in j:
				print("A: ", j)
				check = true
				data[i] = float(j.split(" ")[-1])
			elif (j.split(" ")[-1] != "") and ((i + " = ") in j) and (typeof(float(j.split(" ")[-1])) == typeof(answers[i])) and (typeof(answers[i]) == TYPE_REAL):
				check = true
				print("B: ", i + " = " + j.split(" ")[-1])
				data[i] = float(j.split(" ")[-1])
	emit_signal("runnable", check, data)

func run_code(data=null):
	$CommandObject.run_code(data)

