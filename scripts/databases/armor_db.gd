extends Node
var db = Global.armorDB
var Stat = GameCharacter.Stat

func build_armor_db():
	db["None"]=Armor.new()
	db["Gambeson"]=Armor.new("Gambeson",0, 3, Armor.ArmorType.LIGHT, "Minimal protection for your person.")
	db["Jerkin"]=Armor.new("Jerkin",0, 1, Armor.ArmorType.LIGHT, "A worn jerkin.")
