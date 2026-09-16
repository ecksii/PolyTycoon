extends Node2D

var eye_choice = 8
var mouth_choice = 4
var hair_choice = 1
var skin_tone = Color(0.782, 0.601, 0.849, 1.0)
var hair_color = Color(0.523, 0.158, 0.379, 1.0)

func random_generate():
	eye_choice = randi_range(0, $Eyes/AnimatedSprite2D.sprite_frames.get_frame_count("default"))
	mouth_choice = randi_range(0, $Mouths/AnimatedSprite2D.sprite_frames.get_frame_count("default"))
	hair_choice = randi_range(0, $Head.sprite_frames.get_frame_count("default"))
	skin_tone = Color(randf(), randf(), randf(), 1.0)
	hair_color = Color(randf(), randf(), randf(), 1.0)
	update_head()
	
func update_head():
	$Eyes/AnimatedSprite2D.set_frame_and_progress(eye_choice, 0)
	$Mouths/AnimatedSprite2D.set_frame_and_progress(mouth_choice, 0)
	$Head.set_frame_and_progress(hair_choice, 0)
	$Head.modulate = hair_color
	$Skin.modulate = skin_tone
	$"../UI".update_ui()

func _process(_delta):
	if Input.is_action_just_pressed("generate"):
		random_generate()
		update_head()
