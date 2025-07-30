extends Control

var player:GameCharacter = GameCharacter.new()

var item_info_popup = preload("res://scenes/item_info_popup.tscn")


@onready var pointer_follower = $PointerFollower
var item_info_popup_weapon
var item_info_popup_armor
var item_info_popup_accessory


## Returns a list of items for the specific category of item
func list_inventory(invtype: GameCharacter.InvType):
	return player.inventory[invtype].keys

func update_ui():
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/lblCharName.text = player.character_name
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/lblCurrHP.text = str("HP: ",player.curr_health,"/",player.get_max_health())
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/txProgBarCurrHP.max_value = player.get_max_health()
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/txProgBarCurrHP.value = player.curr_health
	
	
	## Update equipment buttons
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Weapon/mbtnWeapon.text=player.equipped_weapon
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Armor/mbtnArmor.text=player.equipped_armor
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Accessory/mbtnAccessory.text = player.equipped_accessory
	
	## Build text for stats part of UI
	var statstext = str(player.level,"\n",\
						player.money,"\n",\
						player.experience_points,"\n",\
						player.get_stat(GameCharacter.Stat.STR)," (",player.base_stats[GameCharacter.Stat.STR],")\n",\
						player.get_stat(GameCharacter.Stat.DEX)," (",player.base_stats[GameCharacter.Stat.DEX],")\n",\
						player.get_stat(GameCharacter.Stat.CON)," (",player.base_stats[GameCharacter.Stat.CON],")\n",\
						player.get_stat(GameCharacter.Stat.INT)," (",player.base_stats[GameCharacter.Stat.INT],")\n",\
						player.get_accuracy(),"\n",\
						player.get_damage(),"\n",\
						player.get_evasion(),"\n",\
						player.get_armor(),"\n",\
					)
	$Background/VBoxContainer/HBoxContainer/VBoxContainer2/CharStats/txtStatValues.text=statstext
	
	## Clear out any menu buttons
	for child in $Background/VBoxContainer/HBoxContainer/VBoxContainer2/vbItemSlots.get_children():
		$Background/VBoxContainer/HBoxContainer/VBoxContainer2/vbItemSlots.remove_child(child)
		child.queue_free()
	
	## Populate item slots with menu buttons
	var next_item
	for item in player.item_belt:
		next_item = MenuButton.new()
		next_item.text=item
		next_item.flat=false
		$Background/VBoxContainer/HBoxContainer/VBoxContainer2/vbItemSlots.add_child(next_item)
	

func _ready():
	var params = Global.scene_change_params
	player = params["player_character"]
	print("player object:",player,", name:",player.character_name)
	update_ui()
	


func _on_mbtn_weapon_about_to_popup():
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Weapon/mbtnWeapon.get_popup().clear()
	var id=0
	for wpn in player.inventory[GameCharacter.InvType.WEAPON].keys():
		$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Weapon/mbtnWeapon.get_popup().add_item(wpn,id)
		id +=1 
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Weapon/mbtnWeapon.get_popup().id_pressed.connect(_on_wpn_item_selected)
	if (player.equipped_weapon != "") and (player.equipped_weapon != "None"):
		$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Weapon/mbtnWeapon.get_popup().add_item("Un-equip",id)
	print('PLAYER WEAPONS MENU POPPING UP')
	
	
func _on_wpn_item_selected(id : int) -> void:
	var itemname = $Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Weapon/mbtnWeapon.get_popup().get_item_text(id)
	print ("_on_wpn_item_selected(",id,"), text selected is: ",itemname)
	if itemname == "Un-equip":
		player.gain_item(player.equipped_weapon, GameCharacter.InvType.WEAPON)
		player.equipped_weapon = "None"
	else:
		print("SELECTING WEAPON.  WEAPON SELECTED: '",itemname,"'")
		if (player.equipped_weapon != "") and (player.equipped_weapon != "None"):
			player.gain_item(player.equipped_weapon, GameCharacter.InvType.WEAPON)
		player.equipped_weapon = itemname
		player.remove_item(itemname,GameCharacter.InvType.WEAPON)
	
	update_ui()


func _on_mbtn_armor_about_to_popup():
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Armor/mbtnArmor.get_popup().clear()
	var id=0
	for amr in player.inventory[GameCharacter.InvType.ARMOR].keys():
		$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Armor/mbtnArmor.get_popup().add_item(amr,id)
		id +=1 
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Armor/mbtnArmor.get_popup().id_pressed.connect(_on_amr_item_selected)
	if (player.equipped_armor != "") and (player.equipped_armor != "None"):
		$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Armor/mbtnArmor.get_popup().add_item("Un-equip",id)
	print('PLAYER ARMOR MENU POPPING UP')


func _on_amr_item_selected(id : int) -> void:
	var itemname = $Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Armor/mbtnArmor.get_popup().get_item_text(id)
	print ("_on_amr_item_selected(",id,"), text selected is: ",itemname)
	if itemname == "Un-equip":
		player.gain_item(player.equipped_armor, GameCharacter.InvType.ARMOR)
		player.equipped_armor = "None"
	else:
		print("SELECTING ARMOR.  ARMOR SELECTED: '",itemname,"'")
		if (player.equipped_armor != "") and (player.equipped_armor != "None"):
			player.gain_item(player.equipped_armor, GameCharacter.InvType.ARMOR)
		player.equipped_armor = itemname
		player.remove_item(itemname,GameCharacter.InvType.ARMOR)
	
	update_ui()



func _on_mbtn_accessory_about_to_popup():
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Accessory/mbtnAccessory.get_popup().clear()
	var id=0
	for acc in player.inventory[GameCharacter.InvType.ACCESSORY].keys():
		$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Accessory/mbtnAccessory.get_popup().add_item(acc,id)
		id +=1 
	$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Accessory/mbtnAccessory.get_popup().id_pressed.connect(_on_acc_item_selected)
	if (player.equipped_accessory != "") and (player.equipped_accessory != "None"):
		$Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Accessory/mbtnAccessory.get_popup().add_item("Un-equip",id)
	print('PLAYER ACCESSORIES MENU POPPING UP')


func _on_acc_item_selected(id : int) -> void:
	var itemname = $Background/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Accessory/mbtnAccessory.get_popup().get_item_text(id)
	print ("_on_acc_item_selected(",id,"), text selected is: ",itemname)
	if itemname == "Un-equip":
		player.gain_item(player.equipped_accessory, GameCharacter.InvType.ACCESSORY)
		player.equipped_accessory = "None"
	else:
		print("SELECTING ACCESSORY.  ACCESSORY SELECTED: '",itemname,"'")
		if (player.equipped_accessory != "") and (player.equipped_accessory != "None"):
			player.gain_item(player.equipped_accessory, GameCharacter.InvType.ACCESSORY)
		player.equipped_accessory = itemname
		player.remove_item(itemname,GameCharacter.InvType.ACCESSORY)
	
	update_ui()


func _on_mbtn_weapon_mouse_entered():
	Global.scene_change_params={"item_name":player.equipped_weapon,"stats_mods":"statsmods","description":Global.weaponDB[player.equipped_weapon].weapon_description}
	item_info_popup_weapon = item_info_popup.instantiate()
	pointer_follower.add_child(item_info_popup_weapon)
	pointer_follower.current_child = item_info_popup_weapon


func _on_mbtn_weapon_mouse_exited():
	pointer_follower.remove_child(item_info_popup_weapon)
	if item_info_popup_weapon != null:
		item_info_popup_weapon.queue_free()


func _on_mbtn_armor_mouse_entered():
	Global.scene_change_params={"item_name":player.equipped_armor,"stats_mods":"statsmods","description":Global.armorDB[player.equipped_armor].armor_description}
	item_info_popup_armor = item_info_popup.instantiate()
	pointer_follower.add_child(item_info_popup_armor)
	pointer_follower.current_child = item_info_popup_armor


func _on_mbtn_armor_mouse_exited():
	pointer_follower.remove_child(item_info_popup_armor)
	if item_info_popup_armor != null:
		item_info_popup_armor.queue_free()


func _on_mbtn_accessory_mouse_entered():
	Global.scene_change_params={"item_name":player.equipped_accessory,"stats_mods":"statsmods","description":Global.accessoryDB[player.equipped_accessory].accessory_description}
	item_info_popup_accessory = item_info_popup.instantiate()
	pointer_follower.add_child(item_info_popup_accessory)
	pointer_follower.current_child = item_info_popup_accessory


func _on_mbtn_accessory_mouse_exited():
	pointer_follower.remove_child(item_info_popup_accessory)
	if item_info_popup_accessory != null:
		item_info_popup_accessory.queue_free()
