extends Control

func _ready():
	$HBoxContainer/MenuButton.get_popup().add_item("ItemAddedViaScript")
	$HBoxContainer/OptionButton.add_item("OptionAddedViaScript")
