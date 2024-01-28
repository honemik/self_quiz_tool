extends Control


var ran_a := [0,1,2,3,4]
var ans := []
var marking := []
var time_elap := 0
var total := 0
var current = 0
var time_finish := 0
signal finish
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HBoxContainer/VBoxContainer/Test_info/time.text = "時間經過: " + millisecondsToHMS(Time.get_ticks_msec()-time_elap)

func millisecondsToHMS(milliseconds):
	var total_seconds = milliseconds / 1000
	var hours = int(total_seconds / 3600)
	var minutes = int((total_seconds % 3600) / 60)
	var seconds = int(total_seconds % 60)
	return str(hours).pad_zeros(2) + ":" + str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)

func num2ans(value):
	match value:
		0:
			return ""
		1:
			return "A"
		2:
			return "B"
		3:
			return "C"
		4:
			return "D"

func load_problem(index):
	$HBoxContainer/VBoxContainer/question/problem.text = Quizdatabase.current_question_list[index]["problem"]
	$HBoxContainer/VBoxContainer/question/A.text = Quizdatabase.current_question_list[index][num2ans(ran_a[1])]
	$HBoxContainer/VBoxContainer/question/B.text = Quizdatabase.current_question_list[index][num2ans(ran_a[2])]
	$HBoxContainer/VBoxContainer/question/C.text = Quizdatabase.current_question_list[index][num2ans(ran_a[3])]
	$HBoxContainer/VBoxContainer/question/D.text = Quizdatabase.current_question_list[index][num2ans(ran_a[4])]
	current = index
	sync_stat()

func sync_stat():
	match ran_a.find(ans[current]):
		0:
			$HBoxContainer/VBoxContainer/question/A.button_pressed = false
			$HBoxContainer/VBoxContainer/question/B.button_pressed = false
			$HBoxContainer/VBoxContainer/question/C.button_pressed = false
			$HBoxContainer/VBoxContainer/question/D.button_pressed = false
		1:
			$HBoxContainer/VBoxContainer/question/A.button_pressed = true
			$HBoxContainer/VBoxContainer/question/B.button_pressed = false
			$HBoxContainer/VBoxContainer/question/C.button_pressed = false
			$HBoxContainer/VBoxContainer/question/D.button_pressed = false
		2:
			$HBoxContainer/VBoxContainer/question/A.button_pressed = false
			$HBoxContainer/VBoxContainer/question/B.button_pressed = true
			$HBoxContainer/VBoxContainer/question/C.button_pressed = false
			$HBoxContainer/VBoxContainer/question/D.button_pressed = false
		3:
			$HBoxContainer/VBoxContainer/question/A.button_pressed = false
			$HBoxContainer/VBoxContainer/question/B.button_pressed = false
			$HBoxContainer/VBoxContainer/question/C.button_pressed = true
			$HBoxContainer/VBoxContainer/question/D.button_pressed = false
		4:
			$HBoxContainer/VBoxContainer/question/A.button_pressed = false
			$HBoxContainer/VBoxContainer/question/B.button_pressed = false
			$HBoxContainer/VBoxContainer/question/C.button_pressed = false
			$HBoxContainer/VBoxContainer/question/D.button_pressed = true
	match marking[current]:
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
	
	$HBoxContainer/VBoxContainer/Test_info/count.text = "總共題數: " + str(total)
	$HBoxContainer/VBoxContainer/Test_info/answered.text = "目前題目: " + str(current+1)
	$HBoxContainer/VBoxContainer/Test_info/unanswered.text = "未做答題數: " + str(ans.count(0))
			
	
func init_test():
	time_elap = Time.get_ticks_msec()
	total = Quizdatabase.current_question_list.size()
	ans.resize(total)
	ans.fill(0)
	marking.resize(total)
	marking.fill(0)
	ran_a = [1,2,3,4]
	var rand_option = get_node("../CreateQuiz/HBoxContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/random_option")
	if rand_option.button_pressed == false:
		ran_a.shuffle()
		print("隨機亂數.....")
	ran_a.push_front(0)
	print(ran_a)
	$HBoxContainer/VBoxContainer/Test_info/count.text = "總共題數: " + str(total)
	$HBoxContainer/VBoxContainer/Test_info/answered.text = "目前題目: " + str(current+1)
	$HBoxContainer/VBoxContainer/Test_info/unanswered.text = "未做答題數: " + str(ans.count(0))
	load_problem(0)
	



func _on_a_toggled(toggled_on):
	if toggled_on:
		ans[current] = ran_a[1]
		sync_stat()
	else:
		if ans[current] == ran_a[1]:
			ans[current] = 0
			sync_stat()
	


func _on_b_toggled(toggled_on):
	if toggled_on:
		ans[current] = ran_a[2]
		sync_stat()
	else:
		if ans[current] == ran_a[2]:
			ans[current] = 0
			sync_stat()


func _on_c_toggled(toggled_on):
	if toggled_on:
		ans[current] = ran_a[3]
		sync_stat()
	else:
		if ans[current] == ran_a[3]:
			ans[current] = 0
			sync_stat()


func _on_d_toggled(toggled_on):
	if toggled_on:
		ans[current] = ran_a[4]
		sync_stat()
	else:
		if ans[current] ==  ran_a[4]:
			ans[current] = 0
			sync_stat()


func _on_red_tip_toggled(toggled_on):
	if toggled_on:
		marking[current] = 1
		sync_stat()
	else:
		if marking[current] == 1:
			marking[current] = 0
			sync_stat()


func _on_green_tip_toggled(toggled_on):
	if toggled_on:
		marking[current] = 2
		sync_stat()
	else:
		if marking[current] == 2:
			marking[current] = 0
			sync_stat()


func _on_blue_tip_toggled(toggled_on):
	if toggled_on:
		marking[current] = 3
		sync_stat()
	else:
		if marking[current] == 3:
			marking[current] = 0
			sync_stat()

func _on_next_problem_pressed():
	if current + 1 < total:
		load_problem(current+1)



func _on_prev_problem_pressed():
	if current -1  > -1:
		load_problem(current-1)


func _on_finish_pressed():
	print("finish_test...")
	time_finish = Time.get_ticks_msec()
	_on_view_stat_pressed()
	$ItemList.visible = false
	finish.emit()
	
func mark2emoji(value):
	match value:
		0:
			return ""
		1:
			return "🔴"
		2:
			return "🟢"
		3:
			return "🔵"

func _on_view_stat_pressed():
	$ItemList.clear()
	for i in range(0,total):
		$ItemList.add_item(str(i+1)+": "+num2ans(ran_a[ans[i]])+mark2emoji(marking[i])+"      ")
	$ItemList.visible = true


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	load_problem(index)
	$ItemList.visible = false
