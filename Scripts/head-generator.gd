extends Node2D

var eye_choice = 8
var mouth_choice = 4
var skin_tone = Color(0.782, 0.601, 0.849, 1.0)

func random_generate():
	eye_choice = randi_range(0, $Eyes/AnimatedSprite2D.sprite_frames.get_frame_count("default"))
	mouth_choice = randi_range(0, $Mouths/AnimatedSprite2D.sprite_frames.get_frame_count("default"))
	skin_tone = Color(randf(), randf(), randf(), randf())
	
func update_head():
	$Eyes/AnimatedSprite2D.set_frame_and_progress(eye_choice, 0)
	$Mouths/AnimatedSprite2D.set_frame_and_progress(mouth_choice, 0)
	$Skin.modulate = skin_tone

func _ready():
	update_head()

func _process(_delta):
	if Input.is_action_just_pressed("generate"):
		random_generate()
		update_head()
