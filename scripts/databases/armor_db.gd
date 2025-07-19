extends Node

func build_armor_db():
	Global.armorDB["None"]=Armor.new()
	Global.armorDB["Gambeson"]=Armor.new("Gambeson", 1, Armor.ArmorType.LIGHT, "Minimal protection for your person.")
