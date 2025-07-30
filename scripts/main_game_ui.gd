extends Control

var player: GameCharacter
var opponent: GameCharacter
var Stat = GameCharacter.Stat

enum BattleState {
	FIGHTING,
	PLAYER_LOST,
	PLAYER_WON
}
var curr_battle_state = BattleState.FIGHTING

enum Turn {
	PLAYER,
	OPPONENT
}

## Tracker variable to see whose turn it currently is
## (Starts on the player's turn by default)
var current_turn = Turn.PLAYER

## Utility function to pass turn
func pass_turn():
	
	# First, check for end of battle
	if player.curr_health <=0 and opponent.curr_health <=0:
		update_battle_log(str(player.character_name," and ",opponent.character_name,"have both fallen!"))
		current_turn = Turn.OPPONENT
		curr_battle_state = BattleState.PLAYER_LOST
		update_ui()
		return
	elif player.curr_health <=0:
		update_battle_log(str(player.character_name," has fallen!"))
		current_turn = Turn.OPPONENT
		curr_battle_state = BattleState.PLAYER_LOST
		update_ui()
		return
	elif opponent.curr_health <=0: 
		update_battle_log(str(player.character_name," has defeated ",opponent.character_name," in battle!"))
		current_turn = Turn.OPPONENT
		curr_battle_state = BattleState.PLAYER_WON
		update_ui()
		return
	
	
	if current_turn == Turn.PLAYER: 
		current_turn = Turn.OPPONENT
		opponent.process_turn("",player)
		pass_turn()
		update_ui()
	else:
		current_turn = Turn.PLAYER
		update_ui()

func update_battle_log(msg=""):
	if msg != "": 
		Global.update_battle_log(msg)
	## clear log before re-filling
	$Background/VBoxContainer/InfoBox/BattleLog.text = ""
	for x in Global.battle_log:
		$Background/VBoxContainer/InfoBox/BattleLog.text += (x+'\n')

## Check and update all features of the UI
func update_ui():
	
	## Handling UI changes on victory of battle
	if curr_battle_state == BattleState.PLAYER_WON:
		
		## Set up end-of-battle victory recap
		var rewardsmsg = str("VICTORY!\n\n")
		rewardsmsg += str("You gain ",opponent.experience_points," experience points!\n\n")
		if opponent.money > 0:
			rewardsmsg += str("You find ",opponent.money," money on the opponent.\n\n")
		if len(opponent.item_belt) > 0:
			rewardsmsg += str("You find the following items on the opponent:\n")
			for item in opponent.item_belt:
				rewardsmsg += str("-",item,"\n")
			
		## Give player the appropriate rewards
		player.experience_points += opponent.experience_points
		player.money += opponent.money
		for item in opponent.item_belt:
			player.gain_item(item)
		
		## Update text of node
		$Background/VBoxContainer/HBoxContainer/vbEndOfBattleMsgs/rtlRewardsMsg.text=rewardsmsg			
	
	## -- Display or hide "End Battle" button depending on the state of the battle
	$Background/VBoxContainer/HBoxContainer/vbEndOfBattleMsgs.visible = true if ((curr_battle_state == BattleState.PLAYER_LOST) or (curr_battle_state == BattleState.PLAYER_WON)) else false
	
	
	## --- UPDATING PLAYER INFORMATION ---
	# Update player's name
	$Background/VBoxContainer/HBoxContainer/PlayerUI/Name.text = player.character_name
	
	# Update player's current HP
	$Background/VBoxContainer/HBoxContainer/PlayerUI/CurrentHP.text = str("HP: ",player.curr_health,"/",player.get_max_health())
	
	# Update player's health bar
	$Background/VBoxContainer/HBoxContainer/PlayerUI/HealthBar.max_value = player.get_max_health()
	$Background/VBoxContainer/HBoxContainer/PlayerUI/HealthBar.value = player.curr_health
	
	# Update whether the player's buttons are clickable
	$Background/VBoxContainer/HBoxContainer/PlayerUI/BtnAttack.disabled=false if current_turn==Turn.PLAYER else true
	$Background/VBoxContainer/HBoxContainer/PlayerUI/BtnGuard.disabled=false if current_turn==Turn.PLAYER else true
	$Background/VBoxContainer/HBoxContainer/PlayerUI/BtnItem.disabled=false if current_turn==Turn.PLAYER else true
	
	
	## --- UPDATING OPPONENT INFORMATION ---
	# Update opponent's name
	$Background/VBoxContainer/HBoxContainer/OpponentUI/Name.text = opponent.character_name
	
	# Update opponent's current HP TODO 20250719: decide whether to display opponent HP and/or what conditions to do so under
	#$Background/VBoxContainer/HBoxContainer/OpponentUI/CurrentHP.text = str("HP: ",opponent.curr_health,"/",opponent.get_max_health())
	# Update opponent's health bar
	$Background/VBoxContainer/HBoxContainer/OpponentUI/HealthBar.max_value = opponent.get_max_health()
	$Background/VBoxContainer/HBoxContainer/OpponentUI/HealthBar.value = opponent.curr_health
	
	print(opponent.get_battle_msg()," ...current attitude:",opponent.current_attitude)
	$Background/VBoxContainer/HBoxContainer/OpponentUI/OpponentDescription.text = opponent.get_battle_msg()
	update_battle_log()
	

func _ready():
	## TODO 20250726: Find a better way to pass initial state params to the main game UI
	## than through Global.  The ambiguity of manually passing a dictionary is unsafe
	
	## Grab any scene change parameters needed for this scene
	var params = Global.scene_change_params
	
	## Reset room variables as necessary
	curr_battle_state = BattleState.FIGHTING
	
	## TODO 20250727: if it's ever possible for the enemy to go first, ensure 
	## a proper check to see who goes first is established for this flag.
	## Otherwise, the game is currently designed such that the player always 
	## goes first.
	current_turn = Turn.PLAYER
	
	print("setting up characters for upcoming fight:")
	
	player = GameCharacter.new("Devon",{Stat.STR:3,Stat.DEX:3,Stat.CON:3,Stat.INT:3,Stat.BELT_CAP:3},"Club","Jerkin","Side Sachel")
	player.equipped_weapon = "Dagger"
	player.equipped_accessory = "Side Sachel"
	player.gain_item("Healing Balm")
	player.print_health()
	opponent = Global.clone_character(Global.characterDB.get("Goblin", Global.characterDB["None"]))

	## If actual parameters were passed, use those instead
	if params != {}:
		player = params.get("player_character")
		opponent = params.get("opponent")


	## In case the scene was re-entered, reset current turn
	current_turn = Turn.PLAYER
	
	# make an initial update to the UI
	update_ui()
	
	
func _on_btn_attack_pressed():
	player.process_turn("attack", opponent)
	update_battle_log()
	pass_turn()
	pass # Replace with function body.

func _on_btn_guard_pressed():
	player.process_turn("guard")
	pass_turn()

func _on_battle_log_updated():
		## clear log before re-filling
	$Background/VBoxContainer/InfoBox/BattleLog.text = ""
	for x in Global.battle_log:
		$Background/VBoxContainer/InfoBox/BattleLog.text += (x+'\n')

## Populate MenuButton with player's items on player character's item belt
func _on_btn_item_about_to_popup():
	$Background/VBoxContainer/HBoxContainer/PlayerUI/BtnItem.get_popup().clear()
	var id=0
	for item in player.item_belt:
		$Background/VBoxContainer/HBoxContainer/PlayerUI/BtnItem.get_popup().add_item(item,id)
		id +=1 
	$Background/VBoxContainer/HBoxContainer/PlayerUI/BtnItem.get_popup().id_pressed.connect(_on_item_selected)
	print('PLAYER ITEM MENU POPPING UP')

func _on_item_selected(id : int) -> void:
	var itemname = $Background/VBoxContainer/HBoxContainer/PlayerUI/BtnItem.get_popup().get_item_text(id)
	print("USING ITEM.  ITEM SELECTED: '",itemname,"'")
	player.process_turn("use_item", player, itemname)
	pass_turn()


func _on_btn_end_battle_pressed():
	var params = {
		"player_character": player
	}
	Global.scene_change_params = params
	Game.change_scene_to_file("res://scenes/character_management.tscn", params)
