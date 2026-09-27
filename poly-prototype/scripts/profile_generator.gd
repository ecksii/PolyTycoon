class_name ProfileGenerator
extends RefCounted

const FIRST_NAMES: Array[String] = [
	"Hugh", "Lexi", "Emily", "Jack", "David", "Lute", "Bob",
	"Olive", "James", "Becky", "Tim", "Hugo", "Josiah", "Bojack",
	"Walter", "Nolan", "Oliver", "Mark", "Eve", "Bethany", "Maggy",
	"Sarah", "Fiona", "Delilah", "Tony", "Maxine", "Roberto", "Humphry",
	"Tian", "George", "Charlie", "Prongle", "Diplo", "Shakira", "Pitbull",
	"Don", "Saul", "Mary", "Jane", "Barbie", "Ben", "Ken", "Carl"
]

const LAST_NAMES: Array[String] = [
	"Lafferty", "Burke", "Youngman", "White", "Lynch", "Camoot", "Myers",
	"Tree", "Cole", "Moore", "Timple", "Strange", "Davids", "Horseman",
	"Grayson", "Smith", "Washington", "Wilson", "Boolivard", "Joseph",
	"Sillyson", "Applebee", "Gornia", "Stark", "Rogers", "Adams", "Gray",
	"Lee", "Long", "Colinia", "Pringle", "Daplo", "Swift", "Worldwide",
	"Cheadle", "Goodman", "Magdeline", "Doe", "Wick", "Doll", "Dunaval"
]

static func generate() -> Dictionary:
	var first_name: String = FIRST_NAMES.pick_random()
	var last_name: String = LAST_NAMES.pick_random() 
	return {
		"first_name": first_name,
		"last_name": last_name,
		"name": first_name + " " + last_name,
	} 
