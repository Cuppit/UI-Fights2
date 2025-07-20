extends Node

class_name Armor

var armor_name = "Armor name"
var armor_desc = "Armor description"
var base_evasion = 0
var base_armor = 0
var stat_bonuses={"str":0,"dex":0,"con":0}

enum ArmorType{
	LIGHT, ## 
	MEDIUM, ## Strong against slashing
	HEAVY
}

var armor_type = ArmorType.LIGHT

func _init(name="None", eva=0, amr=0, type=ArmorType.LIGHT, desc="Nothing but the clothes on your back.",stat_bons={"str":0,"dex":0,"con":0}):
	armor_name = name
	armor_desc = desc
	base_evasion = eva
	base_armor = amr
	armor_type = type
	stat_bonuses = stat_bons

## Returns a dictionary object that holds all defined weapons in the game, and
## stores it in a global variable for all scripts to use.
func build_armor_db():
	var db = {}
	Global.armorDB = db
