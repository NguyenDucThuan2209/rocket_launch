extends Control

signal onBackHomePressed;
signal onReplayGamePressed;

@export var scoreLabel: RichTextLabel
@export var bestLabel: RichTextLabel

func _on_home_button_pressed() -> void:
	onBackHomePressed.emit()

func _on_replay_button_pressed() -> void:
	onReplayGamePressed.emit()

func initializeEndGameScreen(score: int, best: int) -> void:
	scoreLabel.text = score as String
	bestLabel.text = best as String
