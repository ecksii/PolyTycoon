extends Node

signal dating_count_changed(new_count: int)
signal game_completed

const TOTAL_DATABLE: int = 55_200_000
const BASE_MATCH_CHANCE: float = 0.5

var dating_count: int = 0
var currency: int = 0
var upgrades: Dictionary[String, int] = {
	"better_profile": 0,
	"auto_swiper": 0,
	"date_bot": 0,
}


func add_partner(amount: int = 1) -> void:
	if is_complete():
		return
	dating_count = mini(dating_count + amount, TOTAL_DATABLE)
	dating_count_changed.emit(dating_count)
	
	if is_complete():
		game_completed.emit()

func is_complete() -> bool:
	return dating_count >= TOTAL_DATABLE
	
func get_available_datable() -> int:
	return TOTAL_DATABLE - dating_count
		
