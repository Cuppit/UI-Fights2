extends Node

class_name GameCharacter

## This describes the kind of attitude the character exhibits presently.
## For NPCs, this determines the kind of message displayed, and may also
## impact AI decisions.  For players, it can influence the kind of tactics
## an AI might attept to use.

## Grab same random number generator that's in the global script
var rng = Global.rng

enum Attitude {
	NEUTRAL,  ## When an enemy is exhibiting their normal behavior
	AGGRESSIVE, ## When an enemy is taking up an aggressive posture, attempting to use a strong attack
	DEFENSIVE, ## When an enemy is taking up a defensive posture
	FAINTING ## When below a certain HP threshold, usually, 1/3rd, an enemy has to be at to exhibit close to being defeated
}

## The current attitude of this character (neutral by default)
var current_attitude = Attitude.NEUTRAL

## The types of attitude the character tends to exhibit at the start of a turn
var personality = {Attitude.NEUTRAL:4,Attitude.AGGRESSIVE:1,Attitude.DEFENSIVE:1}

var attitude_msgs = {Attitude.NEUTRAL:["neutralmsg1","neutralmsg2"]\
					 ,Attitude.AGGRESSIVE:["aggressivemsg1","aggressivemsg2"]\
					 ,Attitude.DEFENSIVE:["defensivemsg1","defensivemsg2"]\
					 ,Attitude.FAINTING:["faintingmsg1","faintingmsg2"]}

var action_preferences = { Attitude.NEUTRAL:{"attack":5,"guard":1}\
							,Attitude.AGGRESSIVE:{"attack":1,"guard":0}\
							,Attitude.DEFENSIVE:{"guard":1}\
							,Attitude.FAINTING:{"attack":1,"guard":1}}

## percent HP a character needs to be at in order to express an attitude of "fainting"
var fainting_threshold = 0.33

var character_name = "CharacterName"

var curr_health = 3

## Flag to indicate whether the character is currently guarding
## Guarding 
var guarding = false

var base_str = 1
var base_dex = 1
var base_con = 1

var level = 1

var equipped_weapon = "None"
var equipped_armor = "None"

## Calculates character's current strength based on factors.
## Always returns at least 1 (a character can't effectively have a stat 
## lower than 1 at any time)
func get_str():
	var total = base_str \
		+ Global.weaponDB.get(equipped_weapon,Global.weaponDB["None"]).stat_bonuses.get("str") \
		+ Global.armorDB.get(equipped_armor,Global.armorDB["None"]).stat_bonuses.get("str")
	return total if total > 1 else 1

func get_dex():
	
	print("DEBUG: Global.weaponDB.get(",equipped_weapon,"'None') yields: ",\
		Global.weaponDB.get(equipped_weapon,Global.weaponDB["None"]),"Weapon name is:",\
		Global.weaponDB.get(equipped_weapon,Global.weaponDB["None"]).weapon_name)
	var total = base_dex \
		+ Global.weaponDB.get(equipped_weapon,Global.weaponDB["None"]).stat_bonuses.get("dex") \
		+ Global.armorDB.get(equipped_armor,Global.armorDB["None"]).stat_bonuses.get("dex")
	return total if total > 1 else 1

func get_con():
	var total = base_con \
		+ Global.weaponDB.get(equipped_weapon,Global.weaponDB["None"]).stat_bonuses.get("con") \
		+ Global.armorDB.get(equipped_armor,Global.armorDB["None"]).stat_bonuses.get("con")
		
	return total if total > 1 else 1

# Accuracy stat of a game character
func get_accuracy():
	return 2*get_dex() + get_str()


func get_evasion():
	var to_return = get_dex() + Global.armorDB.get(equipped_armor,Global.armorDB["None"]).base_evasion
	return int((to_return*4)/3) if guarding else to_return


## The damage stat of the character
func get_damage():
	return 2*get_str() + get_dex() + Global.weaponDB.get(equipped_weapon,Global.weaponDB["None"]).weapon_damage
	
##  used in calculating damage reduced from attacks
func get_armor():
	var to_return = get_con()/2 + get_str()/4 + Global.armorDB.get(equipped_armor,Global.armorDB["None"]).base_armor
	return int(((to_return*4)/3)+1) if guarding else to_return # +1 added to ensure guarding causes at least some benefit
	
## Calculates the current max health of the character based on relevant factors.
## More to be defined later, but the most basic factor: constitution * 3.
## (And also max health can never go below 1)
func get_max_health():
	var total = (get_con()*27)
	return total if total > 1 else 1 

## Debug function to test how script hierarchy/scoping works in Godot	
func print_health():
	print(curr_health)	

## Used for selecting any pieces of data dependent on a 
## weighted outcome.
func choose_weighted_outcome(outcomes:Dictionary):
	var weights = outcomes.values()
	var total_weight = 0
	for w in weights:
		total_weight += w
	var rand_choice = rng.randi_range(1, total_weight)
	var cumulative_weight = 0
	var selection = null
	for outcome in outcomes.keys():
		cumulative_weight += outcomes[outcome]
		if rand_choice <= cumulative_weight:
			selection = outcome
			break
	
	return selection

## Returns an appropriate battle message based on the 
## character's current attitude.
func get_battle_msg():
	var msg = rng.randi_range(0,len(attitude_msgs[current_attitude])-1)
	return attitude_msgs[current_attitude][msg]

func process_turn(ability_name="", target=null):
	guarding = false # Reset guarding status before processing turn
	if (ability_name == ""):
		print("No ability name passed, automatically deciding action: ")
		
		var selection = choose_weighted_outcome(action_preferences[current_attitude])
		
		# 3) Execute the chosen ability
		Abilities.execute_ability(self, selection, target)
		
		# 4) Choose a new attitude
		if curr_health < int(get_max_health()*fainting_threshold):
			current_attitude = Attitude.FAINTING
		else:
			current_attitude = choose_weighted_outcome(personality)
	else:
		Abilities.execute_ability(self, ability_name, target)

func _init(chname="Anon",stren=1, dex=1, con=1, weapon="None", armor="None", attitudemsgs=null):
	character_name=chname
	base_str = stren
	base_dex = dex
	base_con = con
	equipped_weapon = weapon
	equipped_armor = armor
	
	if attitudemsgs != null:
		attitude_msgs = attitudemsgs

	
	## Initialize starting stats that are changable (e.g. HP)
	curr_health = get_max_health()
