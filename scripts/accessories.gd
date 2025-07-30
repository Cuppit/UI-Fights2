extends Node

class_name Accessory

var accessory_name="None"
var accessory_description = ""
var stat_bonuses = {}
var money_value = 0

func _init(acname = "None", acdesc="accessorydescription", statbons={}):
	print("CONSTRUCTING NEW ACCESSORY: ",acname)
	accessory_name = acname
	accessory_description=acdesc
	stat_bonuses=statbons
