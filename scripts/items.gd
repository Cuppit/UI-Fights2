extends Node

class_name Item

var item_name = "None"
var description = "itemdescription"
var consumable = false

func _init(iname="None",desc="itemdescription", consume = false):
	item_name=iname
	description=desc
	consumable = consume
