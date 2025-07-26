extends Node
var db = Global.itemDB

func build_item_db():
	db["None"] = Item.new()
	db["Healing Balm"] = Item.new("Healing Balm","Good for recovering a small bit of health.",true)
	db["Strength Potion"] = Item.new("Strength Potion","Boosts the user's strength by 6 for 5 turns.",true)
