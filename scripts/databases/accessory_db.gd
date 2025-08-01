extends Node
var db = Global.accessoryDB
var Stat = GameCharacter.Stat

func build_accessory_db():
	db["None"] = Accessory.new()
	db["Side Satchel"] = Accessory.new("Side Satchel","Provides two extra pockets for items.",{Stat.BELT_CAP:3})
	db["Belt of Strength"] = Accessory.new("Belt of Strength","Moderately boosts strength.",{Stat.STR:3})
