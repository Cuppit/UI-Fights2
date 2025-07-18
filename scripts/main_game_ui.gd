extends Control

var player: GameCharacter

var opponent: GameCharacter


## An array of strings, which is the list of messages reported to the 
## battle manager explaining what's happening
var battle_log = [] 

func _ready():
	#generate the game resources as defined in scripts
	Global.build_weapon_db()
	Global.build_armor_db()
	
	player = GameCharacter.new()
	player.print_health()
	
	opponent = GameCharacter.new()


func _on_btn_attack_pressed():
	battle_log.append(str(player.character_name,"attacks!"))
	player.process_turn("attack", opponent)
	#opponent.process_turn()
	pass # Replace with function body.



func _on_btn_guard_pressed():
	pass # Replace with function body.


func _on_btn_item_pressed():
	pass # Replace with function body.


func _on_btn_stats_pressed():
	pass # Replace with function body.
