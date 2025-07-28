extends Control

signal onBackHomePressed;
signal onReplayGamePressed;

func _on_home_button_pressed() -> void:
	onBackHomePressed.emit()

func _on_replay_button_pressed() -> void:
	onReplayGamePressed.emit()
