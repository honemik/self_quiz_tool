extends Control

var current_problem :=0

signal selecting
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_problem(index):
	$VBoxContainer/HBoxContainer/VBoxContainer/problem.text = Quizdatabase.current_question_list[index]["problem"]
	$VBoxContainer/HBoxContainer/VBoxContainer/A.text = Quizdatabase.current_question_list[index]["A"]
	$VBoxContainer/HBoxContainer/VBoxContainer/B.text = Quizdatabase.current_question_list[index]["B"]
	$VBoxContainer/HBoxContainer/VBoxContainer/C.text = Quizdatabase.current_question_list[index]["C"]
	$VBoxContainer/HBoxContainer/VBoxContainer/D.text = Quizdatabase.current_question_list[index]["D"]
	$VBoxContainer/HBoxContainer/VBoxContainer/explain.text = Quizdatabase.current_question_list[index]["explain"]
	$VBoxContainer/HBoxContainer/VBoxContainer/Tag.text = str(Quizdatabase.current_question_list[index]["tag"])
	
	$VBoxContainer/HBoxContainer/VBoxContainer2/problem_show.text = $VBoxContainer/HBoxContainer/VBoxContainer/problem.text
	$VBoxContainer/HBoxContainer/VBoxContainer2/A.text = $VBoxContainer/HBoxContainer/VBoxContainer/A.text
	$VBoxContainer/HBoxContainer/VBoxContainer2/B.text = $VBoxContainer/HBoxContainer/VBoxContainer/B.text
	$VBoxContainer/HBoxContainer/VBoxContainer2/C.text = $VBoxContainer/HBoxContainer/VBoxContainer/C.text 
	$VBoxContainer/HBoxContainer/VBoxContainer2/D.text = $VBoxContainer/HBoxContainer/VBoxContainer/D.text
	$VBoxContainer/HBoxContainer/VBoxContainer2/explain.text = $VBoxContainer/HBoxContainer/VBoxContainer/explain.text
	$VBoxContainer/HBoxContainer/VBoxContainer2/tag.text = $VBoxContainer/HBoxContainer/VBoxContainer/Tag.text
	
	
	var ar = bool(Quizdatabase.current_question_list[index]["Ar"])
	var br = bool(Quizdatabase.current_question_list[index]["Br"])
	var cr = bool(Quizdatabase.current_question_list[index]["Cr"])
	var dr = bool(Quizdatabase.current_question_list[index]["Dr"])
	$VBoxContainer/HBoxContainer/VBoxContainer2/A.button_pressed = ar
	$VBoxContainer/HBoxContainer/VBoxContainer2/B.button_pressed = br
	$VBoxContainer/HBoxContainer/VBoxContainer2/C.button_pressed = cr
	$VBoxContainer/HBoxContainer/VBoxContainer2/D.button_pressed = dr
	
	
	

func update_problem(index):
	Quizdatabase.current_question_list[index]["problem"] = $VBoxContainer/HBoxContainer/VBoxContainer/problem.text
	Quizdatabase.current_question_list[index]["A"] = $VBoxContainer/HBoxContainer/VBoxContainer/A.text
	Quizdatabase.current_question_list[index]["B"] = $VBoxContainer/HBoxContainer/VBoxContainer/B.text
	Quizdatabase.current_question_list[index]["C"] = $VBoxContainer/HBoxContainer/VBoxContainer/C.text
	Quizdatabase.current_question_list[index]["D"] = $VBoxContainer/HBoxContainer/VBoxContainer/D.text
	Quizdatabase.current_question_list[index]["explain"] = $VBoxContainer/HBoxContainer/VBoxContainer/explain.text
	Quizdatabase.current_question_list[index]["tag"] = str_to_var($VBoxContainer/HBoxContainer/VBoxContainer/Tag.text)
	
	
func update_select():
	$VBoxContainer/HBoxContainer2/select_problem.clear()
	
	for i in range(0,Quizdatabase.current_question_list.size()):
		$VBoxContainer/HBoxContainer2/select_problem.add_item(str(i+1),i)

func update_name():
	$VBoxContainer/HBoxContainer2/DATABASENAME.text = Quizdatabase.current_question_name
		
func _on_problem_text_changed():
	$VBoxContainer/HBoxContainer/VBoxContainer2/problem_show.text = $VBoxContainer/HBoxContainer/VBoxContainer/problem.text
	update_problem(current_problem)


func _on_a_text_changed():
	$VBoxContainer/HBoxContainer/VBoxContainer2/A.text = $VBoxContainer/HBoxContainer/VBoxContainer/A.text
	update_problem(current_problem)


func _on_b_text_changed():
	$VBoxContainer/HBoxContainer/VBoxContainer2/B.text = $VBoxContainer/HBoxContainer/VBoxContainer/B.text
	update_problem(current_problem)


func _on_c_text_changed():
	$VBoxContainer/HBoxContainer/VBoxContainer2/C.text = $VBoxContainer/HBoxContainer/VBoxContainer/C.text # Replace with function body.
	update_problem(current_problem)


func _on_d_text_changed():
	$VBoxContainer/HBoxContainer/VBoxContainer2/D.text = $VBoxContainer/HBoxContainer/VBoxContainer/D.text
	update_problem(current_problem)


func _on_explain_text_changed():
	$VBoxContainer/HBoxContainer/VBoxContainer2/explain.text = $VBoxContainer/HBoxContainer/VBoxContainer/explain.text
	update_problem(current_problem)

func _on_tag_text_changed():
	$VBoxContainer/HBoxContainer/VBoxContainer2/tag.text = $VBoxContainer/HBoxContainer/VBoxContainer/Tag.text
	update_problem(current_problem)


func _on_prev_question_pressed():
	if current_problem-1 >= 0:
		current_problem = current_problem-1
		load_problem(current_problem)
	$VBoxContainer/HBoxContainer2/select_problem.select(current_problem)
	


func _on_next_question_pressed():
	if current_problem+1 < Quizdatabase.current_question_list.size():
		current_problem +=1
		load_problem(current_problem)
	$VBoxContainer/HBoxContainer2/select_problem.select(current_problem)


func _on_add_question_pressed():
	Quizdatabase.current_question_list.insert(current_problem+1 ,{"problem":"1+1=",
		"A":"1",
		"B":"2",
		"C":"3",
		"D":"4",
		"explain":"2+2=4",
		"tag":["math"],
		"Ar":0,
		"Br":0,
		"Cr":0,
		"Dr":0
		})
	current_problem = current_problem+1
	load_problem(current_problem)
	update_select()
	$VBoxContainer/HBoxContainer2/select_problem.select(current_problem)


func _on_del_question_pressed():
	if current_problem-1 < 0 and current_problem+1 == Quizdatabase.current_question_list.size():
		print("this is the last problem")
	elif current_problem-1 >= 0 :
		Quizdatabase.current_question_list.remove_at(current_problem)
		current_problem = current_problem-1
		load_problem(current_problem)
	elif current_problem+1 < Quizdatabase.current_question_list.size():
		Quizdatabase.current_question_list.remove_at(current_problem)
		load_problem(current_problem)
	update_select()
	$VBoxContainer/HBoxContainer2/select_problem.select(current_problem)


func _on_select_problem_item_selected(index):
	current_problem = index
	load_problem(current_problem)



func _on_save_question_pressed():
	Quizdatabase.save_quiz()
	selecting.emit()


func _on_databasename_text_changed():
	Quizdatabase.current_question_name = $VBoxContainer/HBoxContainer2/DATABASENAME.text


func _on_a_toggled(toggled_on):
	Quizdatabase.current_question_list[current_problem]["Ar"] = int(toggled_on)


func _on_b_toggled(toggled_on):
	Quizdatabase.current_question_list[current_problem]["Br"] = int(toggled_on)

func _on_c_toggled(toggled_on):
	Quizdatabase.current_question_list[current_problem]["Cr"] = int(toggled_on)

func _on_d_toggled(toggled_on):
	Quizdatabase.current_question_list[current_problem]["Dr"] = int(toggled_on)
