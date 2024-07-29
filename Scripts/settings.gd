extends Control



func _on_master_value_changed(value):
	AudioServer.set_bus_volume_db(0,value)
	
func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(1,value)

func _on_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(2,value)

func _on_resolutions_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_size(Vector2i(1280, 720))
	
func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")





