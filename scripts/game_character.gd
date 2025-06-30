extends Node

class_name GameCharacter


var curr_health = 3

var base_str = 1
var base_dex = 1
var base_con = 1

var level = 1

var equipped_weapon = null
var equipped_armor = null

## Calculates character's current strength based on factors.
## Always returns at least 1 (a character can't effectively have a stat 
## lower than 0 at any time)
func get_str():
	var total = base_str
	return total if total > 1 else 1

func get_dex():
	var total = base_dex
	return total if total > 1 else 1

func get_con():
	var total = base_con
	return total if total > 1 else 1

## Calculates the current max health of the character based on relevant factors.
## More to be defined later, but the most basic factor: constitution * 3.
func get_max_health():
	var total = (get_con()*3)
	return total if total > 1 else 1 

## Debug function to test how script hierarchy/scoping works in Godot	
func print_health():
	print(curr_health)	


func _init(stren=1, dex=1, con=1):
	base_str = stren
	base_dex = dex
	base_con = con
