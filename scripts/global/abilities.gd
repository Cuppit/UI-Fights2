## This script handles all the code for abilities

extends Node
var rng = Global.rng

## Performs the ability against the target character
func execute_ability(user:GameCharacter, ability_name:String="", tgt:GameCharacter=null):
	match ability_name:
		"attack":
			if tgt==null:
				print("  error in function 'Abilities.execute_ability(",user,ability_name,tgt,")' -- no target for the attack")
			else:
				var roll_range = user.get_accuracy() + tgt.get_evasion()
				var attack_roll = rng.randi_range(1, roll_range)
				if attack_roll > user.get_accuracy():
					Global.battle_log.append(str(user," misses!"))
				else:
					#calculate damage dealt
					var dmg_dealt = user.get_damage() + rng.randi_range(0,user.get_damage())
					var dmg_resisted = tgt.get_armor()
					
					var net_dmg = dmg_dealt - dmg_resisted
					Global.battle_log.append(str(user.character_name," deals ",net_dmg," damage! (",dmg_dealt," dealt - ",dmg_resisted," reduced)"))
					#Apply damage (ensure "negative" damage isn't applied if armor completely blocks attack)
					tgt.curr_health -= net_dmg if net_dmg > 0 else 0
		_:
			print("MSG: Abilities.execute_ability(): No valid ability name attempted to execute?")
