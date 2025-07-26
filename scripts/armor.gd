extends Node

## The code for Armor.

class_name Armor

var armor_name = "Armor name"
var armor_desc = "Armor description"
var base_evasion = 0
var base_armor = 0
var stat_bonuses={}

enum ArmorType{
	LIGHT, ## 
	MEDIUM, ## Strong against slashing
	HEAVY
}

var armor_type = ArmorType.LIGHT

func _init(wname="None", eva=0, amr=0, type=ArmorType.LIGHT, desc="Nothing but the clothes on your back.",stat_bons={}):
	armor_name = wname
	armor_desc = desc
	base_evasion = eva
	base_armor = amr
	armor_type = type
	stat_bonuses = stat_bons
