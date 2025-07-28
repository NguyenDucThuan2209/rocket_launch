extends CanvasLayer

@export var start_game_ui: Control
@export var in_game_ui: Control
@export var pause_game_ui: Control
@export var end_game_ui: Control

func hide_all_game_ui() -> void:
	start_game_ui.hide()
	in_game_ui.hide()
	pause_game_ui.hide()
	end_game_ui.hide()

func on_back_to_home() -> void:
	hide_all_game_ui()
	start_game_ui.show()

func on_pause_game() -> void:
	hide_all_game_ui()
	pause_game_ui.show()
	
	#Main.pause_game()

func on_resume_game() -> void:
	hide_all_game_ui()
	in_game_ui.show()
	
	#Main.resume_game()
