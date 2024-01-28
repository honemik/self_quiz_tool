extends Control

signal adding
signal editing(select)
signal testing(selected_text:Array)

@onready var itemlist = $VBoxContainer/HBoxContainer/ScrollContainer/ItemList
# Called when the node enters the scene tree for the first time.
func _ready():
	update_item()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_editpath_text_changed(new_text):
	Quizdatabase.data_path = new_text
	Quizdatabase.get_quizlist()
	update_item()

func update_item():
	itemlist.clear()
	for i in Quizdatabase.quizlist:
		itemlist.add_item(i)


func _on_testing_pressed():
	var selected:Array = itemlist.get_selected_items()
	var selected_text:Array = []
	for i in selected:
		selected_text.push_back(itemlist.get_item_text(i))
	testing.emit(selected_text)


func _on_editing_pressed():
	var selected:Array = itemlist.get_selected_items()
	if selected.size()>1:
		print("select too much")
	elif(selected.size() ==0):
		print("select nothing")
	else:
		editing.emit(itemlist.get_item_text(selected.front()))
		

func _on_adding_pressed():
	adding.emit()


func _on_deleting_pressed():
	var selected:Array = itemlist.get_selected_items()
	var selected_text:Array = []
	for i in selected:
		Quizdatabase.delete_quiz(itemlist.get_item_text(i))
	update_item()
