extends Node

var rng = RandomNumberGenerator.new()

var weaponDB = {"None":Weapon.new()}
var armorDB = {"None":Armor.new()}
var accessoryDB = {}
var itemDB = {}
var characterDB = {}

## Gain access to scripts designed to build databases for game use
## Potentially over-engineering, however want raw data to be somewhat separate from main logic
var WeaponDBScript = preload("res://scripts/databases/weapon_db.gd")
var ArmorDBScript = preload("res://scripts/databases/armor_db.gd")
var AccessoryDBScript = preload("res://scripts/databases/accessory_db.gd")
var CharacterDBScript = preload("res://scripts/databases/character_db.gd")
var ItemDBScript = preload("res://scripts/databases/item_db.gd") 

## Cleared before every battle.  Battle messages are logged as an array
## of strings that the battle UI pulls from regularly.   

var battle_log = [""]
signal battle_log_updated(battle_log)

# TODO 20250719: remove signal-related stuff like this 
func update_battle_log(msg=""):
	battle_log.append(msg)
	emit_signal("battle_log_updated", msg)

## Function to build the globally accessible weaponDB.
func build_weapon_db():
	var wdbs = WeaponDBScript.new()
	wdbs.build_weapon_db()

func build_armor_db():
	var adbs = ArmorDBScript.new()
	adbs.build_armor_db()

func build_accessory_db():
	var acdbs = AccessoryDBScript.new()
	acdbs.build_accessory_db()
	
func build_character_db():
	var cdbs = CharacterDBScript.new()
	cdbs.build_character_db()

func build_item_db():
	var idbs = ItemDBScript.new()
	idbs.build_item_db()

func clone_character(gchar=characterDB["None"]):
	return GameCharacter.new(gchar.character_name,gchar.base_stats,gchar.equipped_weapon,gchar.equipped_armor,gchar.attitude_msgs)
	
func _ready():
	build_weapon_db()
	build_armor_db()
	build_accessory_db()
	build_item_db()
	build_character_db()
	
