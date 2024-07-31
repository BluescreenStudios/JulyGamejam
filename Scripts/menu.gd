extends Control




func _on_boot_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_levels_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")


func _on_power_off_pressed():
	get_tree().quit()
