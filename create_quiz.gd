extends Control

var tags := []
var tagnumber : Array[int] = []
var T := []
# Called when the node enters the scene tree for the first time.

@onready var container = get_node("./HBoxContainer/VBoxContainer/ScrollContainer/VBoxContainer/H")
signal start_test
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_test_info():
	print("create_test_info...")
	tags.clear()
	tagnumber.clear()
	T.clear()
	
	for i in Quizdatabase.current_question_list:
		for j in i["tag"]:
			var index = tags.find(j)
			if index<0:
				tags.append(j)
				tagnumber.append(1)
			else:
				tagnumber[index] = tagnumber[index]+1
	for i in range(0,tags.size()):
		T.append(container.duplicate())
		container.add_sibling(T[i])
		T[i].visible = true
		T[i].get_node("./T").text = str(tags[i])
		T[i].get_node("./S").min_value = 0
		T[i].get_node("./S").max_value = tagnumber[i]
	


func _on_confirm_pressed():
	var prepared_test := []
	var temp_tag := ""
	var temp_count := 0
	var random_a := []
	for i in T:
		temp_tag = i.get_node("./T").text
		temp_count = i.get_node("./S").value
		if temp_count == 0:
			continue
		if temp_count == i.get_node("./S").max_value:
			for j in Quizdatabase.current_question_list:
				if j["tag"].has(temp_tag):
					prepared_test.append(j)
		else:
			random_a = range(1,i.get_node("./S").max_value+1)
			randomize()
			random_a.shuffle()
			random_a = random_a.slice(0,temp_count)
			random_a.sort()
			temp_count = 1
			for j in Quizdatabase.current_question_list:
				if j["tag"].has(temp_tag):
					if random_a.has(temp_count):
						prepared_test.append(j)
					temp_count = temp_count +1
	print("準備考試.....")
	print(prepared_test)
	prepared_test.shuffle()
	Quizdatabase.current_question_list = prepared_test
	for i in T:
		i.queue_free()
	start_test.emit()
	

func tag2index(value:String):
	return tags.find(value)

