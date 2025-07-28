extends Control

var player:GameCharacter = GameCharacter.new()

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
	
	## Populate item slots with menu buttons
	var next_item
	for item in player.item_belt:
		next_item = MenuButton.new()
		next_item.text=item.item_name
		$Background/VBoxContainer/HBoxContainer/VBoxContainer2/vbItemSlots.add_child(MenuButton.new())
	
	
	
	
func _ready():
	var params = Global.scene_change_params
	player = params["player_character"]
	print("player object:",player,", name:",player.character_name)
	update_ui()
