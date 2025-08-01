extends PanelContainer

var params = Global.scene_change_params


func _ready() -> void:
	$VBoxContainer/ItemName.text = params["item_name"]
	#$ItemInfoPopup/PanelContainer/VBoxContainer/ItemIcon.text = 
	$VBoxContainer/StatsMods.text = params["stats_mods"]
	$VBoxContainer/Description.text = params["description"]
	print("POPUP SIZE:",self.size)
