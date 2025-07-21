extends Control

var player: GameCharacter
var opponent: GameCharacter

enum Turn {
	PLAYER,
	OPPONENT
}

## Tracker variable to see whose turn it currently is
## (Starts on the player's turn by default)
var current_turn = Turn.PLAYER

## Utility function to pass turn
func pass_turn():
	
	# First, check  for end of battle
	if player.curr_health <=0 and opponent.curr_health <=0:
		update_battle_log(str(player.character_name," and ",opponent.character_name,"have both fallen!"))
		current_turn = Turn.OPPONENT
		update_ui()
		return
	elif player.curr_health <=0:
		update_battle_log(str(player.character_name," has fallen!"))
		current_turn = Turn.OPPONENT
		update_ui()
		return
	elif opponent.curr_health <=0: 
		update_battle_log(str(player.character_name," has defeated ",opponent.character_name," in battle!"))
		current_turn = Turn.OPPONENT
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
	$Background/VBoxContainer/HBoxContainer/PlayerUI/BtnStats.disabled=false if current_turn==Turn.PLAYER else true
	
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
	# Connect signals
	# Global.connect("battle_log_updated", self, "_on_battle_log_updated")
	
	#generate the game resources as defined in scripts
	print("Building game databases:")
	Global.build_weapon_db()
	Global.build_armor_db()
	Global.build_character_db()
	
	print("building characters:")
	player = GameCharacter.new("Devon",3,3,3)
	player.equipped_weapon = "Dagger"
	player.print_health()
	
	opponent = Global.clone_character(Global.characterDB.get("Goblin", Global.characterDB["None"]))
	
	# make an initial update to the UI
	update_ui()

func _on_btn_attack_pressed():
	player.process_turn("attack", opponent)
	update_battle_log()
	pass_turn()
	pass # Replace with function body.

func _on_btn_guard_pressed():
	update_battle_log(str("--\n",player.character_name," is guarding!"))
	player.process_turn("guard")
	pass_turn()

func _on_btn_item_pressed():
	pass # Replace with function body.

func _on_btn_stats_pressed():
	pass # Replace with function body.

func _on_battle_log_updated():
		## clear log before re-filling
	$Background/VBoxContainer/InfoBox/BattleLog.text = ""
	for x in Global.battle_log:
		$Background/VBoxContainer/InfoBox/BattleLog.text += (x+'\n')
