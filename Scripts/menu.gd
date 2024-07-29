extends Control




func _on_boot_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")


func _on_shut_down_pressed():
	get_tree().quit()
