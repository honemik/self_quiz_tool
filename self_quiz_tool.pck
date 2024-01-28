GDPC                P                                                                      "   T   res://.godot/exported/133200997/export-40070a71f43bb7bc9d59c3e68bc5f90c-review.scn  �      z      �#-���É Ɇ�h��    T   res://.godot/exported/133200997/export-4d9aa192cdb7b401cb46049a2cbaab3b-panel.scn   Љ      �      y�ǲM��v�ɾ��    P   res://.godot/exported/133200997/export-57c5cf7baf6d152754251a37d4717258-blue.res@�            ��8u^!z7�av}�''    X   res://.godot/exported/133200997/export-7c706b42d453075bc1972218ebbfd454-selecting.scn           �	      �P)4��(����'�    P   res://.godot/exported/133200997/export-9a65423820b7b37cea100f8f297a3221-red.res ��      a      �0���S������j    T   res://.godot/exported/133200997/export-9ac872396e00e527e17e6fbb731f9011-editing.scn �\      �      �kS���v�e8    X   res://.godot/exported/133200997/export-9c243c9fb88f0551b7cfe8256d0cd375-optioncheck.res 0|      �      �	L�$
�<GA�    T   res://.godot/exported/133200997/export-bcb0e670ec38b8334ae4bd478f7062d6-quizing.scn �      S      �<|(;86����    X   res://.godot/exported/133200997/export-cab82fce84221f484f5871f5a8f59a1a-create_quiz.scn �9      a      D��Ɇ���q!S�D;�    T   res://.godot/exported/133200997/export-d0bc7f5d8df845080607a2ffb0973731-green.res   �      )      A<X�u��Z7�nV    ,   res://.godot/global_script_class_cache.cfg  ��             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�n      �      �̛�*$q�*�́        res://.godot/uid_cache.bin  ��      d      �@L�h�^'8�>|e       res://V.gd  p       )      ��c����,?iba��       res://blue.tres.remap   @�      a       ��H���2�ȁ\
R�_       res://create_quiz.gdp�      )      r�;l�X�i��Xo�J�       res://create_quiz.tscn.remap@�      h       źC����9�ryXi       res://editing.gd B      �      w��~�'�A����Y       res://editing.tscn.remap��      d       ���q�5�����6�+�       res://green.tres.remap  ��      b       g����Z���Rd;$�F       res://icon.svg  ��      �      C��=U���^Qu��U3       res://icon.svg.import   `{      �       ?�_��թ��|��r�       res://optioncheck.tres.remap �      h       ��b!�Q���D�m{       res://panel.gd  Є      �      ��\\떆��.v�80       res://panel.tscn.remap  ��      b       f��6�`�U�~4CX       res://project.binary �      �      n��!=N�D�e�"���       res://quizdatabase.gd   ��      X
      6�'�q3,����@�G�       res://quizing.gd�      �      ��f�>P�>�;���[       res://quizing.tscn.remap �      d       z��"i�(.�����       res://red.tres.remapp�      `       �x(�a0腌����       res://review.gd �!            ,x"`F�\_}}� ��       res://review.tscn.remap ��      c       L��}D�(#��p���       res://selecting.gd  �	            �k��i��F ���߫�       res://selecting.tscn.remap  `�      f       c:e[�AQF�(O��        RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://selecting.gd ��������      local://PackedScene_cxf8f 
         PackedScene          	         names "   '   
   Selecting    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    VBoxContainer    ReferenceRect2    size_flags_vertical    ReferenceRect    HBoxContainer    size_flags_stretch_ratio    ReferenceRect3    size_flags_horizontal    ScrollContainer 	   ItemList    select_mode    ReferenceRect4    HBoxContainer2    ADDING    text    Button    EDITING 	   DELETING    TESTING 	   editpath    placeholder_text 	   LineEdit    ReferenceRect5    _on_adding_pressed    pressed    _on_editing_pressed    _on_deleting_pressed    _on_testing_pressed    _on_editpath_text_changed    text_changed    	   variants                        �?                         �(8A   ��4A      @      新增       編輯       刪除       測驗    !   D:\\Code\\self_quiz_tool\\quiz\\       PATH       node_count             nodes     �   ��������       ����                                                          	   	   ����                                                     
   ����                                 ����                                       ����                                        ����                                       ����                                              ����                                        ����                                       ����                                        ����                   	                    ����                   
                    ����                                       ����                                       ����                                             ����                                        ����                          conn_count             conns     #   
       !                         !   "                     !   #                     !   $                     &   %                    node_paths              editable_instances              version             RSRC         extends Control

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
            RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://review.gd ��������   Theme    res://optioncheck.tres �S�a�wB   Theme    res://red.tres Ex����2   Theme    res://green.tres ߱�ɤ#|   Theme    res://blue.tres �k��oV      local://PackedScene_xo185 �         PackedScene          	         names "   B      Control    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    HBoxContainer    ReferenceRect3    size_flags_horizontal    size_flags_vertical    ReferenceRect    VBoxContainer    size_flags_stretch_ratio 
   alignment 
   Test_info    cur    text    Label    count 	   answered    unanswered    time 
   View_stat    toggle_mode    Button 	   question    HSeparator    problem    bbcode_enabled    fit_content    RichTextLabel    A    theme 	   CheckBox    B    C    D    explain    control    prev_problem    next_problem    RED_tip 
   GREEN_tip 	   BLUE_tip    ReferenceRect2 
   ColorRect    visible    offset_left    offset_top    offset_right    offset_bottom    color    Result    S    L    horizontal_alignment    P    value    ProgressBar    _on_view_stat_toggled    toggled    _on_prev_problem_pressed    pressed    _on_next_problem_pressed    	   variants    )                    �?                         �pAA      目前題目:        總共題數:        答對題數       答錯題數       時間          
   看狀態       A     �@      HI

                A       B       C       D    
   上一題    
   下一題                紅                綠                藍             C     CC    ��D    �xD   �� >�� >�� >  �?     	�     ��      HI            HB      node_count    &         nodes     0  ��������        ����                                                                ����                                                     	   ����         
                               ����         
                                 	   ����         
                               ����                                       ����         
                              ����         
                              ����         
          	                    ����         
          
                    ����         
                              ����         
                                    ����                                       ����                           ����                                                   #   !   ����                "                       #   $   ����                "                       #   %   ����                "                       #   &   ����                "                           '   ����                                                      (   ����                              	   ����         
                            )   ����         
                           *   ����         
                           +   ����         
       "                                ,   ����         
       "                                -   ����         
       "                                .   ����         
                               ����                              .   ����         
                          /   /   ����   0            1      2       3   !   4   "   5   #                  6   ����   0                              1      2       3   $   4   %                                ����                              7   ����   0                       !          8   ����         
          &   9          !       <   :   ����         
          '   ;   (       !          	   ����         
                            .   ����                          conn_count             conns               >   =                     @   ?                     @   A                    node_paths              editable_instances              version             RSRC      extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_s_value_changed(value):
	self.text = str(value)
       extends Control


var current :=0
@onready var quizing = get_node("../quizing")
@onready var create = get_node("../CreateQuiz")
@onready var container = get_node("./Result/S")
# Called when the node enters the scene tree for the first time.
var right_count := []
var right_all :=0
var VT :=[]
var total
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_problem(index):
	current = index
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
			
	if Quizdatabase.check_ans(current,quizing.ran_a[1]) != (quizing.ran_a[quizing.ans[current]]==1) :
		$HBoxContainer/VBoxContainer/question/A.disabled = true
	if Quizdatabase.check_ans(current,quizing.ran_a[2]) != (quizing.ran_a[quizing.ans[current]]==2):
		$HBoxContainer/VBoxContainer/question/B.disabled = true
	if Quizdatabase.check_ans(current,quizing.ran_a[3]) != (quizing.ran_a[quizing.ans[current]]==3) :
		$HBoxContainer/VBoxContainer/question/C.disabled = true
	if Quizdatabase.check_ans(current,quizing.ran_a[4]) != (quizing.ran_a[quizing.ans[current]]==4) :
		$HBoxContainer/VBoxContainer/question/D.disabled = true
	
	match quizing.ran_a[quizing.ans[current]]:
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
	$HBoxContainer/VBoxContainer/Test_info/time.text = "經過時間: " + quizing.millisecondsToHMS(quizing.time_finish - quizing.time_elap)
	$HBoxContainer/VBoxContainer/Test_info/count.text = str(Quizdatabase.current_question_list.size())
	right_count.resize(create.tags.size())
	right_count.fill(0)
	for i in range(0,Quizdatabase.current_question_list.size()):
		if Quizdatabase.check_ans(i,quizing.ans[i]):
			for j in Quizdatabase.current_question_list[i]["tag"]:
				right_count[create.tag2index(j)] +=1
	for i in range(0,right_count.size()):
		right_all+=right_count[i]
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
 RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://create_quiz.gd ��������   Script    res://V.gd ��������      local://PackedScene_dm6a6 .         PackedScene          	         names "   #      CreateQuiz    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    HBoxContainer    ReferenceRect2    size_flags_horizontal    ReferenceRect    VBoxContainer    size_flags_stretch_ratio    ReferenceRect3    size_flags_vertical    ScrollContainer    H    visible    T    text    Label    S 
   max_value    value    HSlider    V    confirm    Button    ReferenceRect4    _on_s_value_changed    value_changed    _on_confirm_pressed    pressed    	   variants                        �?                         {A   H�@                   時間(分鐘)    R��@     �C     �B               開始測驗       node_count             nodes     �   ��������       ����                                                          	   	   ����                                                     
   ����                                 ����                                       ����                                        ����                                       ����                                  	      ����                                       ����                   	      
                    ����                   	                                      ����                                       ����                                       ����                                        ����                          conn_count             conns        	   
                            "   !                    node_paths              editable_instances              version             RSRC               extends Control

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
	
	$VBoxContainer/HBoxContainer/VBoxContainer2/A.button_pressed = bool(Quizdatabase.current_question_list[index]["Ar"])
	$VBoxContainer/HBoxContainer/VBoxContainer2/B.button_pressed = bool(Quizdatabase.current_question_list[index]["Br"])
	$VBoxContainer/HBoxContainer/VBoxContainer2/C.button_pressed = bool(Quizdatabase.current_question_list[index]["Cr"])
	$VBoxContainer/HBoxContainer/VBoxContainer2/D.button_pressed = bool(Quizdatabase.current_question_list[index]["Dr"])
	
	
	

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
		$VBoxContainer/HBoxContainer2/select_problem.add_item(str(i),i)

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
		current_problem = current_problem+1
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
	print(current_problem)
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
              RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://editing.gd ��������   Theme    res://optioncheck.tres �S�a�wB      local://PackedScene_aptmg 5         PackedScene          	         names "   E      Editing    layout_mode    anchors_preset    offset_right    offset_bottom    script    Control    VBoxContainer    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    size_flags_horizontal    ReferenceRect2    size_flags_vertical    ReferenceRect    HBoxContainer    size_flags_stretch_ratio    problem    placeholder_text 	   TextEdit    A    B    C    D    explain    Tag    ReferenceRect3    VBoxContainer2    problem_show    bbcode_enabled    RichTextLabel    theme 	   CheckBox    tag    HBoxContainer2    prev_question    text    Button    next_question    add_question    del_question    select_problem    OptionButton    DATABASENAME    save_question    ReferenceRect4    _on_problem_text_changed    text_changed    _on_a_text_changed    _on_b_text_changed    _on_c_text_changed    _on_d_text_changed    _on_explain_text_changed    _on_tag_text_changed    _on_a_toggled    toggled    _on_b_toggled    _on_c_toggled    _on_d_toggled    _on_prev_question_pressed    pressed    _on_next_question_pressed    _on_add_question_pressed    _on_del_question_pressed !   _on_select_problem_item_selected    item_selected    _on_databasename_text_changed    _on_save_question_pressed    	   variants                         �D     �D                           �?            A     �@      問題       正解       B       C       D       詳解       TAG:                   
   上一題    
   下一題       新增問題       刪除問題       TITLE       儲存並退出       node_count    "         nodes     �  ��������       ����                                                    ����                     	      
                                    ����                                 ����                   	                    ����                                 ����                   
                    ����                          
                          ����                                              ����                                              ����                                              ����                                              ����                          
                          ����                                              ����                                 ����                   
                    ����                          
                    !      ����                                  !      ����                                  !      ����                                  !      ����                                        ����                          
                       "   ����                                        ����                              #   ����                                 ����                           &   $   ����                %                 &   '   ����                %                 &   (   ����                %                 &   )   ����                %                 +   *   ����                              ,   ����                                 &   -   ����                %                    .   ����                                 ����                          conn_count             conns     ~          0   /                     0   1                     0   2              	       0   3              
       0   4                     0   5                     0   6                     8   7                     8   9                     8   :                     8   ;                     =   <                     =   >                     =   ?                     =   @                     B   A                     0   C                     =   D                    node_paths              editable_instances              version             RSRC         GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[             [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dnebbu1qpblpl"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                RSRC                    Theme            ��������                                            )      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script 	   gradient    width    use_hdr    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom    texture    texture_margin_left    texture_margin_top    texture_margin_right    texture_margin_bottom    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    axis_stretch_horizontal    axis_stretch_vertical    region_rect    modulate_color    draw_center    default_base_scale    default_font    default_font_size    CheckBox/colors/font_color $   CheckBox/colors/font_disabled_color !   CheckBox/colors/font_hover_color )   CheckBox/colors/font_hover_pressed_color #   CheckBox/colors/font_pressed_color    CheckBox/styles/disabled    CheckBox/styles/hover    CheckBox/styles/hover_pressed    CheckBox/styles/normal    CheckBox/styles/pressed     
      local://Gradient_rt7ge �          local://GradientTexture1D_erlwx          local://StyleBoxTexture_8l3jg =         local://Gradient_2g8xx m          local://GradientTexture1D_2s8wu �         local://StyleBoxTexture_n5fng �         local://Gradient_q3372           local://GradientTexture1D_hs5ti Y         local://StyleBoxTexture_d2g5h �         local://Theme_e1xr8 �      	   Gradient       $      ���>�*?ԁ�>  �?��L?��@?��^?  �?         GradientTexture1D                          StyleBoxTexture                      	   Gradient       $                    �?l=s>l=s>l=s>  �?         GradientTexture1D                         StyleBoxTexture                      	   Gradient       $        �?  �?  �?  �?u�d?�I?s*E?  �?         GradientTexture1D                         StyleBoxTexture                         Theme          ��_?��_?��_?  �?                     �?!      33s?33s?33s?  �?"                    �?#                    �?$            %            &            '            (                  RSRC   extends Control



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
	$Selecting.visible = true
	$Editing.visible = false
	$Selecting.update_item()
	


func _on_create_quiz_start_test():
	$CreateQuiz.visible = false
	$quizing.visible = true
	$quizing.init_test()


func _on_quizing_finish():
	$review.visible = true
	$quizing.visible = false
	$review.init_review()
           RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    default_base_scale    default_font    default_font_size    script 	   _bundled       Script    res://panel.gd ��������   PackedScene    res://editing.tscn 5H���A   PackedScene    res://quizing.tscn �"t�Y.B   PackedScene    res://selecting.tscn ���|E
�d   PackedScene    res://create_quiz.tscn Sj�bE��(   PackedScene    res://review.tscn �1|Ύ�S=      local://Theme_t45xd T         local://PackedScene_xwn7x v         Theme          $            PackedScene          	         names "         Panel    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    theme    script    Control    Editing    visible 
   Selecting    CreateQuiz    quizing    review    _on_editing_selecting 
   selecting    _on_selecting_adding    adding    _on_selecting_editing    editing    _on_selecting_testing    testing    _on_create_quiz_start_test    start_test    _on_quizing_finish    finish    	   variants                        �?                                                                                          node_count             nodes     U   ��������	       ����                                                                ���
                           ���	                  	               ���   
         	               ���                  	               ���                  	               ���                  	             conn_count             conns     *                                                                                                                                                         node_paths              editable_instances              version             RSRC            extends Node

var data_path = "D:\\Code\\self_quiz_tool\\quiz\\"

var current_question_name := "hi"
var current_question_list:= []
var quizlist = []

var prepared_test := []

func _ready():
	if  OS.get_executable_path() != null:
		data_path = OS.get_executable_path().get_base_dir() + "/quiz/"
		print(data_path)
		if DirAccess.dir_exists_absolute(data_path)==false:
			DirAccess.make_dir_absolute(data_path)
	
	get_quizlist()
	
	
func read_json(filename:String):
	var open_err = FileAccess.open(data_path+filename+".json", FileAccess.READ)
	var json_object = JSON.new()
	var parse_err = json_object.parse(open_err.get_as_text())
	return json_object.get_data()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_quizlist():
	if FileAccess.file_exists(data_path+"list.json") == false:
		save_quizlist()
	var data_received = read_json("list")
	if typeof(data_received) == TYPE_ARRAY:
		quizlist = data_received # 输出 array
	#檢查檔案
	for i in quizlist:
		if FileAccess.file_exists(data_path+i+".json") == false:
			delete_quiz(i)
	save_quizlist()
	
func save_quizlist():
	
	var open_err = FileAccess.open(data_path+"list.json", FileAccess.WRITE_READ)
	open_err.store_string(JSON.stringify(quizlist))

func delete_quiz(quizname):
	if FileAccess.file_exists(data_path+quizname+".json"):
		DirAccess.remove_absolute(data_path+quizname+".json")
	quizlist.erase(quizname)

func load_quiz(quizname):
	current_question_name = quizname
	var data_received = read_json(quizname)
	if typeof(data_received) == TYPE_ARRAY:
		current_question_list = data_received # 输出 array

func save_quiz():
	var open_err = FileAccess.open(data_path+current_question_name+".json", FileAccess.WRITE_READ)
	open_err.store_string(JSON.stringify(current_question_list))
	if quizlist.has(current_question_name) == false:
		quizlist.append(current_question_name)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_quizlist()
		get_tree().quit() # default behavior


func get_quizftest(selected:Array):
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
	else:
		print(value)
        extends Control


var ran_a := [0,1,2,3,4]
var ans := []
var marking := []
var time_elap = 0
var total := 0
var current = 0
var time_finish = 0
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
	match ran_a[ans[current]]:
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
	ran_a.shuffle()
	ran_a.push_front(0)
	$HBoxContainer/VBoxContainer/Test_info/count.text = "總共題數: " + str(total)
	$HBoxContainer/VBoxContainer/Test_info/answered.text = "目前題目: " + str(current+1)
	$HBoxContainer/VBoxContainer/Test_info/unanswered.text = "未做答題數: " + str(ans.count(0))
	load_problem(0)
	



func _on_a_toggled(toggled_on):
	if toggled_on:
		ans[current] = ran_a.find(1)
	else:
		if ans[current] == 1:
			ans[current] = 0
	sync_stat()


func _on_b_toggled(toggled_on):
	if toggled_on:
		ans[current] = ran_a.find(2)
	else:
		if ans[current] == ran_a.find(2):
			ans[current] = 0
	sync_stat()


func _on_c_toggled(toggled_on):
	if toggled_on:
		ans[current] = ran_a.find(3)
	else:
		if ans[current] == ran_a.find(3):
			ans[current] = 0
	sync_stat()


func _on_d_toggled(toggled_on):
	if toggled_on:
		ans[current] = ran_a.find(4)
	else:
		if ans[current] ==  ran_a.find(4):
			ans[current] = 0
	sync_stat()


func _on_red_tip_toggled(toggled_on):
	if toggled_on:
		marking[current] = 1
	else:
		if marking[current] == 1:
			marking[current] = 0
	sync_stat()


func _on_green_tip_toggled(toggled_on):
	if toggled_on:
		marking[current] = 2
	else:
		if marking[current] == 2:
			marking[current] = 0
	sync_stat()


func _on_blue_tip_toggled(toggled_on):
	if toggled_on:
		marking[current] = 3
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
	time_finish = Time.get_ticks_msec()
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
         RSRC                    PackedScene            ��������                                            &      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script 	   gradient    width    height    use_hdr    fill 
   fill_from    fill_to    repeat    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom    texture    texture_margin_left    texture_margin_top    texture_margin_right    texture_margin_bottom    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    axis_stretch_horizontal    axis_stretch_vertical    region_rect    modulate_color    draw_center    default_base_scale    default_font    default_font_size    ItemList/styles/panel 	   _bundled       Script    res://quizing.gd ��������   Theme    res://optioncheck.tres �S�a�wB   Theme    res://red.tres Ex����2   Theme    res://green.tres ߱�ɤ#|   Theme    res://blue.tres �k��oV      local://Gradient_favs2 �          local://GradientTexture2D_5a43e D         local://StyleBoxTexture_nq4cy �         local://Theme_lxhn7 �         local://PackedScene_eao8h �      	   Gradient       !          �?  �?   $      ���=          �?x'o>��N>�c>  �?am�>hʎ>0�>  �?         GradientTexture2D                    
         �?         StyleBoxTexture                         Theme    $                     PackedScene    %      	         names "   F      Control    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    HBoxContainer    ReferenceRect3    size_flags_horizontal    size_flags_vertical    ReferenceRect    VBoxContainer    size_flags_stretch_ratio 
   alignment 
   Test_info    count    text    Label 	   answered    unanswered    time 
   View_stat    Button 	   question    HSeparator    problem    bbcode_enabled    fit_content    RichTextLabel    A    theme 	   CheckBox    B    C    D    control    prev_problem    next_problem    RED_tip    toggle_mode 
   GREEN_tip 	   BLUE_tip    finish    ReferenceRect2 	   ItemList    visible    offset_left    offset_top    offset_right    offset_bottom    auto_height    max_columns    same_column_width    _on_view_stat_pressed    pressed    _on_a_toggled    toggled    _on_b_toggled    _on_c_toggled    _on_d_toggled    _on_prev_problem_pressed    _on_next_problem_pressed    _on_red_tip_toggled    _on_green_tip_toggled    _on_blue_tip_toggled    _on_finish_pressed    _on_item_list_item_clicked    item_clicked    	   variants    &                    �?                         �pAA      總共題數:        已做答題數:        未做答題數       經過時間    
   看狀態       A     �@            HI

                A       B       C       D    
   上一題    
   下一題                紅                綠                藍       完成                    C     �B    ��D    �{D                     node_count             nodes     �  ��������        ����                                                                ����                                                     	   ����         
                               ����         
                                 	   ����         
                               ����                                       ����         
                              ����         
                              ����         
          	                    ����         
          
                    ����         
                              ����                                       ����                          ����                                                   !      ����                                        !   "   ����                                        !   #   ����                                        !   $   ����                                           %   ����                              	   ����         
                            &   ����         
                           '   ����         
                           (   ����         
              )                          *   ����         
              )                          +   ����         
              )                          ,   ����         
                           -   ����         
                               ����                              -   ����         
                          .   .   ����
   /            0       1   !   2   "   3   #       $   4      5   %   6                conn_count             conns     T   
       8   7                     :   9                     :   ;                     :   <                     :   =                     8   >                     8   ?                     :   @                     :   A                     :   B                     8   C                     E   D                    node_paths              editable_instances              version             RSRC             extends Control

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
	print(prepared_test)
	print(random_a)
	prepared_test.shuffle()
	Quizdatabase.current_question_list = prepared_test
	start_test.emit()

func tag2index(value:String):
	return tags.find(value)

       RSRC                    Theme            ��������                                            '      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script 	   gradient    width    height    use_hdr    fill 
   fill_from    fill_to    repeat    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom    texture    texture_margin_left    texture_margin_top    texture_margin_right    texture_margin_bottom    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    axis_stretch_horizontal    axis_stretch_vertical    region_rect    modulate_color    draw_center    default_base_scale    default_font    default_font_size    Button/styles/hover    Button/styles/normal    Button/styles/pressed           local://Gradient_1h5pr �          local://GradientTexture2D_cvxmc �         local://StyleBoxTexture_d1u1f          local://Gradient_cc87k L          local://GradientTexture2D_40q5n �         local://StyleBoxTexture_gmr8i �         local://Theme_hvq2f       	   Gradient       !          U~?   $      ���>��->׌�<  �?�y(?�6�;N_o>  �?         GradientTexture2D                    
       <k3?         StyleBoxTexture                      	   Gradient       !          U~?   $        �?���>���>  �?�y?��'?��,?  �?         GradientTexture2D                   
       �-�>         StyleBoxTexture                         Theme    $            %            &                  RSRC               RSRC                    Theme            ��������                                            '      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script 	   gradient    width    height    use_hdr    fill 
   fill_from    fill_to    repeat    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom    texture    texture_margin_left    texture_margin_top    texture_margin_right    texture_margin_bottom    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    axis_stretch_horizontal    axis_stretch_vertical    region_rect    modulate_color    draw_center    default_base_scale    default_font    default_font_size    Button/styles/hover    Button/styles/normal    Button/styles/pressed           local://Gradient_wg1fm �          local://GradientTexture2D_7c7a4 �         local://StyleBoxTexture_x7skd �         local://Gradient_5uxhs (          local://GradientTexture2D_kbwxa m         local://StyleBoxTexture_b2qnt �         local://Theme_bo1vp �      	   Gradient       $          �?輎>  �?���>���>���>  �?         GradientTexture2D                          StyleBoxTexture                      	   Gradient       $      ���>  �?��?  �?��0?ܠ&?      �?         GradientTexture2D                   
   ��~?���>         StyleBoxTexture                         Theme    $            %            &                  RSRC       RSRC                    Theme            ��������                                            '      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script 	   gradient    width    height    use_hdr    fill 
   fill_from    fill_to    repeat    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom    texture    texture_margin_left    texture_margin_top    texture_margin_right    texture_margin_bottom    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    axis_stretch_horizontal    axis_stretch_vertical    region_rect    modulate_color    draw_center    default_base_scale    default_font    default_font_size    Button/styles/hover    Button/styles/normal    Button/styles/pressed           local://Gradient_ms3ik �          local://GradientTexture2D_lh8w2 �         local://StyleBoxTexture_6c7m6 �         local://Gradient_qyqkc (          local://GradientTexture2D_0s78s m         local://StyleBoxTexture_x8d6q �         local://Theme_0k7wt �      	   Gradient       $              ���>  �?��$>���>���>  �?         GradientTexture2D                          StyleBoxTexture                      	   Gradient       $                �?  �?��?��T>��J?  �?         GradientTexture2D                         StyleBoxTexture                         Theme    $            %            &                  RSRC       [remap]

path="res://.godot/exported/133200997/export-7c706b42d453075bc1972218ebbfd454-selecting.scn"
          [remap]

path="res://.godot/exported/133200997/export-40070a71f43bb7bc9d59c3e68bc5f90c-review.scn"
             [remap]

path="res://.godot/exported/133200997/export-cab82fce84221f484f5871f5a8f59a1a-create_quiz.scn"
        [remap]

path="res://.godot/exported/133200997/export-9ac872396e00e527e17e6fbb731f9011-editing.scn"
            [remap]

path="res://.godot/exported/133200997/export-9c243c9fb88f0551b7cfe8256d0cd375-optioncheck.res"
        [remap]

path="res://.godot/exported/133200997/export-4d9aa192cdb7b401cb46049a2cbaab3b-panel.scn"
              [remap]

path="res://.godot/exported/133200997/export-bcb0e670ec38b8334ae4bd478f7062d6-quizing.scn"
            [remap]

path="res://.godot/exported/133200997/export-9a65423820b7b37cea100f8f297a3221-red.res"
[remap]

path="res://.godot/exported/133200997/export-d0bc7f5d8df845080607a2ffb0973731-green.res"
              [remap]

path="res://.godot/exported/133200997/export-57c5cf7baf6d152754251a37d4717258-blue.res"
               list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             Sj�bE��(   res://create_quiz.tscn5H���A   res://editing.tscn�w%�"p   res://icon.svg�S�a�wB   res://optioncheck.tresyָ����c   res://panel.tscn�"t�Y.B   res://quizing.tscn�1|Ύ�S=   res://review.tscn���|E
�d   res://selecting.tscn�~σ��   res://panel.tresEx����2   res://red.tres߱�ɤ#|   res://green.tres�k��oV   res://blue.tres            ECFG      application/config/name         self_quiz_tool     application/run/main_scene         res://panel.tscn   application/config/features   "         4.2    Mobile     application/config/icon         res://icon.svg     autoload/Quizdatabase          *res://quizdatabase.gd  "   display/window/size/viewport_width      �  #   display/window/size/viewport_height      8  #   rendering/renderer/rendering_method         mobile      