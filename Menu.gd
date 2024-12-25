extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://WagonScreen.tscn")

func _on_options_pressed() -> void:
	$SettingsPopup.popup_centered()
	$SettingsPopup/AutoCloseTimer.start()

func _on_quit_pressed() -> void:
	get_tree().quit() #quits out of the .exe

func _on_auto_close_timer_timeout() -> void:
	$SettingsPopup.hide() # Replace with function body.
