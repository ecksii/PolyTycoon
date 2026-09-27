extends Node2D

var lane_position: Array[int] = [160, 480, 800]
var colors: Array[Color] = [Color.RED, Color.GREEN, Color.BLUE]
var block_scene = preload("res://scenes/block.tscn")
var lanes: Array[Area2D] = [] 
var selected: bool = false
var current_selection: int = 1
var score: int = 0
var enemy_health: int = 100
var player_health: int = 100


func _ready() -> void:
	$spawnTimer.wait_time = 1.5
	$spawnTimer.timeout.connect(spawn_falling)
	$spawnTimer.start()
	for i in 3:
		var player_blocks: Area2D = block_scene.instantiate() 
		player_blocks.modulate = colors[i] 
		player_blocks.position = Vector2(lane_position[i], 560)
		player_blocks.area_entered.connect(on_hit.bind(player_blocks))
		add_child(player_blocks) 
		lanes.append(player_blocks)
	selection_heights()
	
func spawn_falling() -> void:
	var falling_blocks: Area2D = block_scene.instantiate()
	falling_blocks.modulate = colors[randi() % 3]
	falling_blocks.position = Vector2(lane_position[randi()%3], 100)
	falling_blocks.monitoring = false 
	falling_blocks.add_to_group("falling")
	add_child(falling_blocks)

func _process(delta) -> void:
	for blocks_falling in get_tree().get_nodes_in_group("falling"):
		blocks_falling.position.y += 150 * delta
		if blocks_falling.position.y > 920:
			blocks_falling.queue_free()
	for player_block in get_tree().get_nodes_in_group("flying"):
		player_block.position.y -= 700 * delta
		if player_block.position.y < 0:
			player_health = player_health - 10
			land(player_block)
	$score.text = "Score: " + str(score)
	$EnemyHealthBar.value = enemy_health
	$PlayerHealthBar.value = player_health
	if enemy_health <= 0 or player_health <=0:
		$spawnTimer.stop()
		$score.text = "Game Over."
	
func selection_heights() -> void:
	for i in 3:
		if lanes[i].is_in_group("flying"):
			continue
		if i == current_selection:
			lanes[i].position.y = 760 if selected else 800
		else:
			lanes[i].position.y = 820
			
func move(direction) -> void:
	var target: int = clamp(current_selection + direction, 0, 2)
	if selected and target != current_selection:
		var current_block: Area2D = lanes[current_selection]
		var target_block: Area2D = lanes[target]
		lanes[current_selection] = target_block
		lanes[target] = current_block
		current_block.position.x = lane_position[target]
		target_block.position.x = lane_position[current_selection]
	current_selection = target
	selection_heights()

func land(block) -> void:
	if block.is_in_group("flying"):
		block.remove_from_group("flying")
	selection_heights()
	
func on_hit(enemy_block, players_block) -> void:
	if enemy_block.modulate == players_block.modulate:
		enemy_health = enemy_health - 5
	else:
		player_health = player_health - 10
	enemy_block.queue_free()
	land(players_block)

func _unhandled_input(event) -> void:
	if event.is_action_pressed("move_left"):
		move(-1)
	elif event.is_action_pressed("move_right"):
		move(1)
	elif event.is_action_pressed("select"):
		selected = not selected
		selection_heights()
	elif event.is_action_pressed("launch") and selected:
		lanes[current_selection].add_to_group("flying")
		selected = false
