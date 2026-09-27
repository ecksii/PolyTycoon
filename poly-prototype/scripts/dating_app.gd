class_name DatingApp
extends VBoxContainer

signal back_pressed

var current_profile: Dictionary = {}

@onready var name_label: Label = $Profile/NameLabel
@onready var match_confirm: Label = $MatchConfirm

func _ready() -> void:
	show_next_profile()

func show_next_profile() -> void:
	current_profile = ProfileGenerator.generate()
	name_label.text = current_profile["name"]

func handle_match(profile: Dictionary) -> void:
	match_confirm.text = "It's a match with " + profile["name"] + "!"
	GameState.add_partner()
	

func _on_swipe_button_pressed() -> void:
	if randf() < GameState.BASE_MATCH_CHANCE:
		handle_match(current_profile)
	else:
		match_confirm.text = ""
	show_next_profile()

func _on_back_button_pressed() -> void:
	back_pressed.emit()
