extends Control



@onready var quizing := get_node("../quizing")
@onready var create := get_node("../CreateQuiz")
@onready var container := get_node("./Result/S")

var right_count := []
var right_all :=0
var VT :=[]
var total :=0
var current :=0


signal finish_review

func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_problem(index):
	current = index
	$HBoxContainer/VBoxContainer/control/OptionButton.selected = index
	$HBoxContainer/VBoxContainer/Test_info/cur.text = "目前題目: " + str(current+1)
	$HBoxContainer/VBoxContainer/question/problem.text = Quizdatabase.current_question_list[index]["problem"]
	$HBoxContainer/VBoxContainer/question/A.text = Quizdatabase.current_question_list[index][quizing.num2ans(quizing.ran_a[1])]
	$HBoxContainer/VBoxContainer/question/B.text = Quizdatabase.current_question_list[index][quizing.num2ans(quizing.ran_a[2])]
	$HBoxContainer/VBoxContainer/question/C.text = Quizdatabase.current_question_list[index][quizing.num2ans(quizing.ran_a[3])]
	$HBoxContainer/VBoxContainer/question/D.text = Quizdatabase.current_question_list[index][quizing.num2ans(quizing.ran_a[4])]
	$HBoxContainer/VBoxContainer/question/explain.text = Quizdatabase.current_question_list[index]["explain"]
	$HBoxContainer/VBoxContainer/question/A.disabled = false
	$HBoxContainer/VBoxContainer/question/B.disabled = false
	$HBoxContainer/VBoxContainer/question/C.disabled = false
	$HBoxContainer/VBoxContainer/question/D.disabled = false
	sync_stat()
	
func sync_stat():
	
	if Quizdatabase.check_ans(current,quizing.ran_a[1]) != (quizing.ran_a.find(quizing.ans[current])==1):
		$HBoxContainer/VBoxContainer/question/A.disabled = true
	if Quizdatabase.check_ans(current,quizing.ran_a[2]) != (quizing.ran_a.find(quizing.ans[current])==2):
		$HBoxContainer/VBoxContainer/question/B.disabled = true
	if Quizdatabase.check_ans(current,quizing.ran_a[3]) != (quizing.ran_a.find(quizing.ans[current])==3):
		$HBoxContainer/VBoxContainer/question/C.disabled = true
	if Quizdatabase.check_ans(current,quizing.ran_a[4]) != (quizing.ran_a.find(quizing.ans[current])==4):
		$HBoxContainer/VBoxContainer/question/D.disabled = true
		
	match quizing.ran_a.find(quizing.ans[current]):
		0:
			$HBoxContainer/VBoxContainer/question/A.button_pressed = false
			$HBoxContainer/VBoxContainer/question/B.button_pressed = false
			$HBoxContainer/VBoxContainer/question/C.button_pressed = false
			$HBoxContainer/VBoxContainer/question/D.button_pressed = false
		1:
			$HBoxContainer/VBoxContainer/question/A.disabled = false
			$HBoxContainer/VBoxContainer/question/A.button_pressed = true
			$HBoxContainer/VBoxContainer/question/B.button_pressed = false
			$HBoxContainer/VBoxContainer/question/C.button_pressed = false
			$HBoxContainer/VBoxContainer/question/D.button_pressed = false
		2:
			$HBoxContainer/VBoxContainer/question/B.disabled = false
			$HBoxContainer/VBoxContainer/question/A.button_pressed = false
			$HBoxContainer/VBoxContainer/question/B.button_pressed = true
			$HBoxContainer/VBoxContainer/question/C.button_pressed = false
			$HBoxContainer/VBoxContainer/question/D.button_pressed = false
		3:
			$HBoxContainer/VBoxContainer/question/C.disabled = false
			$HBoxContainer/VBoxContainer/question/A.button_pressed = false
			$HBoxContainer/VBoxContainer/question/B.button_pressed = false
			$HBoxContainer/VBoxContainer/question/C.button_pressed = true
			$HBoxContainer/VBoxContainer/question/D.button_pressed = false
		4:
			$HBoxContainer/VBoxContainer/question/D.disabled = false
			$HBoxContainer/VBoxContainer/question/A.button_pressed = false
			$HBoxContainer/VBoxContainer/question/B.button_pressed = false
			$HBoxContainer/VBoxContainer/question/C.button_pressed = false
			$HBoxContainer/VBoxContainer/question/D.button_pressed = true
	match quizing.marking[current]:
		0:
			$HBoxContainer/VBoxContainer/control/RED_tip.button_pressed = false
			$HBoxContainer/VBoxContainer/control/GREEN_tip.button_pressed = false
			$HBoxContainer/VBoxContainer/control/BLUE_tip.button_pressed = false
		1:
			$HBoxContainer/VBoxContainer/control/RED_tip.button_pressed = true
			$HBoxContainer/VBoxContainer/control/GREEN_tip.button_pressed = false
			$HBoxContainer/VBoxContainer/control/BLUE_tip.button_pressed = false
		2:
			$HBoxContainer/VBoxContainer/control/RED_tip.button_pressed = false
			$HBoxContainer/VBoxContainer/control/GREEN_tip.button_pressed = true
			$HBoxContainer/VBoxContainer/control/BLUE_tip.button_pressed = false
		3:
			$HBoxContainer/VBoxContainer/control/RED_tip.button_pressed = false
			$HBoxContainer/VBoxContainer/control/GREEN_tip.button_pressed = false
			$HBoxContainer/VBoxContainer/control/BLUE_tip.button_pressed = true
		
		

func init_review():
	
	print("review_init...")
	$HBoxContainer/VBoxContainer/Test_info/time.text = "經過時間: " + quizing.millisecondsToHMS(quizing.time_finish - quizing.time_elap)
	$HBoxContainer/VBoxContainer/Test_info/count.text = "全部題目: " + str(Quizdatabase.current_question_list.size())
	var optionb = get_node("./HBoxContainer/VBoxContainer/control/OptionButton")
	optionb.clear()
	right_count.resize(create.tags.size())
	right_count.fill(0)
	right_all = 0
	for i in range(0,Quizdatabase.current_question_list.size()):
		if Quizdatabase.check_ans(i,quizing.ans[i]):
			for j in Quizdatabase.current_question_list[i]["tag"]:
				right_count[create.tag2index(j)] +=1
			optionb.add_item(str(i+1) + ": "+ quizing.mark2emoji(2))
			right_all +=1
		else:
			optionb.add_item(str(i+1) + ": "+ quizing.mark2emoji(1))
	for i in range(0,right_count.size()):
		VT.append(container.duplicate())
		container.add_sibling(VT[i])
		VT[i].visible = true
		VT[i].get_node("./L").text = create.tags[i]
		VT[i].get_node("./P").value = right_count[i] / create.tagnumber[i] * 100
	$HBoxContainer/VBoxContainer/Test_info/answered.text = "答對題數: " + str(right_all)
	$HBoxContainer/VBoxContainer/Test_info/unanswered.text = "答錯題數: " + str(Quizdatabase.current_question_list.size() - right_all)
	total = quizing.total
	load_problem(0)


func _on_view_stat_toggled(toggled_on):
	if toggled_on:
		$ColorRect.visible = true
		$Result.visible = true
	else:
		$ColorRect.visible = false
		$Result.visible = false


func _on_next_problem_pressed():
	if current + 1 < total:
		load_problem(current+1)


func _on_prev_problem_pressed():
	if current -1  > -1:
		load_problem(current-1)


func _on_option_button_item_selected(index):
	load_problem(index)


func _on_finish_pressed():
	for i in VT:
		i.queue_free()
	VT.clear()
	finish_review.emit()
