extends Control

signal onPauseGamePressed;
signal onAudioGamePressed;

func _on_pause_button_pressed() -> void:
	onPauseGamePressed.emit()

func _on_sound_button_pressed() -> void:
	onAudioGamePressed.emit()

func updateScore(score: int) -> void:
	$Score.text = score as String
