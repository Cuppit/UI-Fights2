extends Node
var db = Global.accessoryDB
var Stat = GameCharacter.Stat

func build_accessory_db():
	db["None"] = Accessory.new()
	db["Side Satchel"] = Accessory.new("Side Satchel","Provides an extra pocket for items.",{Stat.BELT_CAP:1})
