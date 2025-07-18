extends Node

class_name GameCharacter

var character_name = "CharacterName"

var curr_health = 3

var base_str = 1
var base_dex = 1
var base_con = 1

var level = 1

var equipped_weapon = "None"
var equipped_armor = "None"

## Calculates character's current strength based on factors.
## Always returns at least 1 (a character can't effectively have a stat 
## lower than 1 at any time)
func get_str():
	var total = base_str \
		+ Global.weaponDB.get(equipped_weapon,"None").stat_bonuses.get("str") \
		+ Global.armorDB.get(equipped_armor,"None").stat_bonuses.get("str")
	return total if total > 1 else 1

func get_dex():
	
	print("DEBUG: type of Global.weaponDB.get(equipped_weapon,'None') is: ",Global.weaponDB.get(equipped_weapon,"None"))
	var total = base_dex \
		+ Global.weaponDB.get(equipped_weapon,"None").stat_bonuses.get("dex") \
		+ Global.armorDB.get(equipped_armor,"None").stat_bonuses.get("dex")
	return total if total > 1 else 1

func get_con():
	var total = base_con \
		+ Global.weaponDB.get(equipped_weapon,"None").stat_bonuses.get("con") \
		+ Global.armorDB.get(equipped_armor,"None").stat_bonuses.get("con")
		
	return total if total > 1 else 1

# Accuracy stat of a game character
func get_accuracy():
	return 2*get_dex() + get_str()

func get_evasion():
	return get_dex()
	
# The damage stat of the character
func get_damage():
	return 2*get_str() + get_dex() + Global.weaponDB.get(equipped_weapon,"None").weapon_damage
	
# used in calculating damage reduced from attacks
func get_armor():
	return get_con()/2 + get_str()/4 + Global.armorDB.get(equipped_armor,"None").base_armor
## Calculates the current max health of the character based on relevant factors.
## More to be defined later, but the most basic factor: constitution * 3.
## (And also max health can never go below 1)
func get_max_health():
	var total = (get_con()*3)
	return total if total > 1 else 1 

## Debug function to test how script hierarchy/scoping works in Godot	
func print_health():
	print(curr_health)	

func process_turn(ability_name="", target=null):
	Abilities.execute_ability(self, ability_name, target)

func _init(stren=1, dex=1, con=1):
	base_str = stren
	base_dex = dex
	base_con = con
