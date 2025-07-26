extends Node

class_name Accessory

var accessory_name="None"
var description = ""
var stat_bonuses = {}

func _init(acname = "None", acdesc="accessorydescription", statbons={}):
	print("CONSTRUCTING NEW ACCESSORY: ",acname)
	accessory_name = acname
	description=acdesc
	stat_bonuses=statbons
