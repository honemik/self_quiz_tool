extends Node

var data_path = "D:\\Code\\self_quiz_tool\\quiz\\"

var current_question_name := "hi"
var current_question_list:= []
var quizlist = []

var prepared_test := []

func _ready():
	if  OS.get_executable_path() != null:
		data_path = OS.get_executable_path().get_base_dir() + "/quiz/"
		if DirAccess.dir_exists_absolute(data_path)==false:
			DirAccess.make_dir_absolute(data_path)
			print("create dir")
	
	get_quizlist()
	print("running in :" + data_path)
	
func read_json(filename:String):
	var open_err = FileAccess.open(data_path+filename+".json", FileAccess.READ)
	var json_object = JSON.new()
	var parse_err = json_object.parse(open_err.get_as_text())
	open_err.close()
	return json_object.get_data()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_quizlist():
	if FileAccess.file_exists(data_path+"list.json") == false:
		save_quizlist()
		print("create list")
	var data_received = read_json("list")
	if typeof(data_received) == TYPE_ARRAY:
		quizlist = data_received # 输出 array
	#檢查檔案
	for i in quizlist:
		if FileAccess.file_exists(data_path+i+".json") == false:
			delete_quiz(i)
	save_quizlist()
	
func save_quizlist():
	print("saving list......")
	var open_err = FileAccess.open(data_path+"list.json", FileAccess.WRITE_READ)
	open_err.store_string(JSON.stringify(quizlist))

func delete_quiz(quizname):
	print("delete quiz: " + quizname)
	if FileAccess.file_exists(data_path+quizname+".json"):
		print("find file and delete")
		DirAccess.remove_absolute(data_path+quizname+".json")
	print("remove from list")
	quizlist.erase(quizname)

func load_quiz(quizname):
	current_question_list.clear()
	current_question_name = quizname
	var data_received = read_json(quizname)
	if typeof(data_received) == TYPE_ARRAY:
		current_question_list = data_received # 输出 array

func save_quiz():
	print("saving quiz: " + current_question_name)
	var open_err = FileAccess.open(data_path+current_question_name+".json", FileAccess.WRITE_READ)
	open_err.store_string(JSON.stringify(current_question_list))
	if quizlist.has(current_question_name) == false:
		quizlist.append(current_question_name)
		print("update list: " + current_question_name)
		save_quizlist()
	
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_quizlist()
		get_tree().quit() # default behavior


func get_quizftest(selected:Array):
	current_question_list.clear()
	prepared_test = selected
	for i in prepared_test:
		var data_received = read_json(i)
		if typeof(data_received) == TYPE_ARRAY:
			current_question_list.append_array(data_received)
	current_question_list.sort_custom(func(a,b): return a["tag"] > b["tag"])
	
func check_ans(index,value):
	if value == 1:
		return bool(current_question_list[index]["Ar"])
	elif value == 2:
		return bool(current_question_list[index]["Br"])
	elif value == 3:
		return bool(current_question_list[index]["Cr"])
	elif value == 4:
		return bool(current_question_list[index]["Dr"])

func clearquiz():
	current_question_list.clear()
	prepared_test.clear()
	current_question_name = "a"
	
