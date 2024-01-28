extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().size_changed.connect(_on_viewport_size_changed)

func _on_viewport_size_changed():
	theme.default_font_size = min(get_viewport().size.y,get_viewport().size.x)/30


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_selecting_adding():
	$Selecting.visible = false
	$Editing.visible = true
	$Editing.update_name()
	$Editing.current_problem = -1
	$Editing._on_add_question_pressed()


func _on_selecting_editing(select):
	$Selecting.visible = false
	$Editing.visible = true
	Quizdatabase.load_quiz(select)
	$Editing.load_problem(0)
	$Editing.update_select()
	$Editing.update_name()


func _on_selecting_testing(selected_text):
	$Selecting.visible = false
	$CreateQuiz.visible = true
	Quizdatabase.get_quizftest(selected_text)
	$CreateQuiz.create_test_info()


func _on_editing_selecting():
	$Editing.visible = false
	$Selecting.visible = true
	$Selecting.update_item()
	


func _on_create_quiz_start_test():
	$CreateQuiz.visible = false
	$quizing.visible = true
	$quizing.init_test()


func _on_quizing_finish():
	$quizing.visible = false
	$review.visible = true
	$review.init_review()

func _on_review_finish_review():
	$review.visible = false
	$Selecting.visible = true
	

	
