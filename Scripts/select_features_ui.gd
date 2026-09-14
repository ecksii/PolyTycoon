extends Node2D

var eye_count: int = 0
var mouth_count: int = 0

@onready var HEAD = $"../Head"

func update_slider_positions():
	$MouthsSlider.value = HEAD.mouth_choice
	$EyesSlider.value = HEAD.eye_choice
	
func update_color_picker():
	$SkinColorPicker.color = HEAD.skin_tone
	
func update_ui():
	update_slider_positions()
	update_color_picker()

func _ready():
	eye_count = $"../Head/Eyes/AnimatedSprite2D".sprite_frames.get_frame_count("default")
	mouth_count = $"../Head/Mouths/AnimatedSprite2D".sprite_frames.get_frame_count("default")

	$MouthsSlider.tick_count = mouth_count
	$MouthsSlider.max_value = eye_count - 1
	$EyesSlider.tick_count = eye_count
	$EyesSlider.max_value = eye_count - 1
	
	update_slider_positions()

func _on_mouths_slider_value_changed(value):
	$"../Head/Mouths/AnimatedSprite2D".set_frame_and_progress($MouthsSlider.value, 0)

func _on_eyes_slider_value_changed(value):
	$"../Head/Eyes/AnimatedSprite2D".set_frame_and_progress($EyesSlider.value, 0)

func _on_randomise_btn_button_down():
	$"../Head".random_generate()

func _on_skin_color_picker_color_changed(color):
	HEAD.skin_tone = $SkinColorPicker.color
	HEAD.update_head()
