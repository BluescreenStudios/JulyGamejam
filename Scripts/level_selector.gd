extends MenuButton


func send_to_level(ID):
	match(ID):
		0:
			get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
		
