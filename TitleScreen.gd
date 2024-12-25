extends Control

var popup_shown : bool = false

func _ready():
	$SettingsPopup.hide()  # Hide the popup initially
	popup_shown = false

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://WagonScreen.tscn")

func _on_options_pressed() -> void:
	if not popup_shown:
		$SettingsPopup/Label.text = "Settings only available for paid subscribers. Subscribe today!"
		$SettingsPopup.popup()
		$SettingsPopup/AutoCloseTimer.start()
		popup_shown = true
	else:
		$SettingsPopup/Label.text = "No, really. My venmo is Ittai-Eres"
		$SettingsPopup.popup()
		$SettingsPopup/AutoCloseTimer.start()
		popup_shown = false

func _on_quit_pressed() -> void:
	get_tree().quit() #quits out of the .exe

func _on_auto_close_timer_timeout() -> void:
	$SettingsPopup.hide() # Replace with function body.
