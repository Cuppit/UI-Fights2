## This script handles all the code for abilities

extends Node
var rng = Global.rng
var ItemEffects = preload("res://scripts/global/item_effects.gd")
var item_effects = ItemEffects.new()


## Performs the ability against the target character
func execute_ability(user:GameCharacter, ability_name:String="", tgt:GameCharacter=null, item_name:String=""):
	Global.battle_log.append(str("--\n"))
	match ability_name:
		"attack":
			if tgt==null:
				print("  error in function 'Abilities.execute_ability(",user,ability_name,tgt,")' -- no target for the attack")
			else:
				Global.battle_log.append(str(user.character_name," attacks!"))
				var roll_range = user.get_accuracy() + tgt.get_evasion()
				var attack_roll = rng.randi_range(1, roll_range)
				if attack_roll > user.get_accuracy():
					Global.battle_log.append(str(user.character_name," misses!"))
				else:
					#calculate damage dealt
					var dmg_dealt = user.get_damage() + rng.randi_range(0,user.get_damage())
					var dmg_resisted = tgt.get_armor()
					
					var net_dmg = dmg_dealt - dmg_resisted
					Global.battle_log.append(str(user.character_name," deals ",net_dmg," damage! (",dmg_dealt," dealt - ",dmg_resisted," reduced)"))
					#Apply damage (ensure "negative" damage isn't applied if armor completely blocks attack)
					tgt.curr_health -= net_dmg if net_dmg > 0 else 0
		"guard":
			print("BEFORE guarding, character ",user.character_name," has ",user.get_evasion()," evasion, and ",user.get_armor()," armor.")
			Global.battle_log.append(str(user.character_name," is guarding!"))
			user.guarding=true
			print("AFTER guarding, character ",user.character_name," has ",user.get_evasion()," evasion, and ",user.get_armor()," armor.")
		
		"use_item":
			if (item_name == ""):
				print("ERROR in 'use_item' in abilities.gd: ability invoked, but no valid item name found")
			
			if item_name not in user.item_belt:
				print("ERROR in 'use_item' in abilities.gd: use_item invoked, but item doesn't exist in user's item belt")
			
			else:
				item_effects.use_item(user, item_name, tgt)
		_:
			print("MSG: Abilities.execute_ability(): No script found for specified ability?")
