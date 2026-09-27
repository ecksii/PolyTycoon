extends Control

const ROOM_PHONE: Texture2D = preload("res://art/room_phone.png")
const ROOM_NO_PHONE: Texture2D = preload("res://art/room_no_phone.png")

@onready var score_track: Label = $Score
@onready var people_track: Label = $Datables
@onready var phone_ui: phoneUI = $PhoneUI
@onready var background: TextureRect = $Background

func _ready() -> void:
	GameState.dating_count_changed.connect(update_score)
	GameState.dating_count_changed.connect(update_people)
	GameState.game_completed.connect(on_game_completed)
	phone_ui.closed.connect(_on_phone_closed)
	update_score(GameState.dating_count)
	update_people(GameState.dating_count)

func _on_phone_closed() -> void:
	background.texture = ROOM_PHONE

func _on_phone_pressed() -> void:
	background.texture = ROOM_NO_PHONE
	phone_ui.open()
	
func update_score(count) -> void:
	score_track.text = "Dating: " + str(count)

func update_people(count) -> void:
	people_track.text = "Available: " + str(GameState.get_available_datable())

func on_game_completed() -> void:
	print("You are now dating everyone in the UK!")

func _on_door_pressed() -> void:
	get_tree().quit()

func _on_shop_pressed() -> void:
	print("Shop clicked")
