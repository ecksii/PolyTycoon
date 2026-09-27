class_name phoneUI
extends Control
signal closed

@onready var home_screen: VBoxContainer = $Case/Screen
@onready var dating_app: DatingApp = $Case/DatingApp

func open() -> void:
	show()

func close() -> void:
	hide()
	closed.emit()

func _on_dating_app_pressed() -> void:
	home_screen.hide()
	dating_app.show()

func _on_close_phone_pressed() -> void:
	close()

func _on_backdrop_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			close()


func _on_dating_app_back_pressed() -> void:
	dating_app.hide()
	home_screen.show()
