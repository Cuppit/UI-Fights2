extends Control

enum ChosenClass {
	FIGHTER,
	SAGE,
	BANDIT
}

## Transparency to set character portraits to
const HIGHLIGHT_SETTING = Color(1.00, 1.00, 1.00, 1.00)
const TRANS_SETTING = Color(1.00, 1.00, 1.00, 0.40)

var curr_chosen_class = null

## Implementation: each character class has a description text block, a "pros/cons" block,
## and an abilities description block.  Each block of text is stored as an element of an
## array that's the value to a key associated with each class.  The first element is 
## description, the second is pros/cons, the third is abilities.

var descriptions = {ChosenClass.FIGHTER:{ \
	'description':"The Fighter has a lot of resilience, and can also deal \
	consistent damage to opponents.", \

	'proscons':"PROS--\n-High HP\n-High Physical Damage\n--CONS--\n-lower \
	dexterity, fewer abilities", \

	'abilities':"(some description of abilities goes here)"}, \


	ChosenClass.SAGE:{ \
	'description':"The Sage has access to arcane knowledge, and can apply\
	it to success in combat.", \
	
	'proscons':"PROS--\n-High Int\n-High Physical Damage\n--CONS--\n-resource-\
	based tactics, lower HP and physical damage", \
	
	'abilities':"(some description of abilities goes here)"}, \


	ChosenClass.BANDIT:{ \
	'description':"The Bandit has proficiency with items nobody else has, and \
	focuses on dodging attacks.", \
	
	'proscons':"PROS--\n-High Dex\n-occasionally strikes critical hits in combat \
	\n--CONS--\n-low HP \n-Relies heavily on luck to strike critically", \
	
	'abilities':"(some description of abilities goes here)"}	
	}


func select_class(chosen:ChosenClass):
	curr_chosen_class = chosen
	
	# -- Update the button highlights --
	$Background/VBoxContainer/HBoxContainer/BtnPackFighter.modulate = \
		HIGHLIGHT_SETTING if chosen == ChosenClass.FIGHTER else TRANS_SETTING
	$Background/VBoxContainer/HBoxContainer/BtnPackSage.modulate = \
		HIGHLIGHT_SETTING if chosen == ChosenClass.SAGE else TRANS_SETTING
	$Background/VBoxContainer/HBoxContainer/BtnPackBandit.modulate = \
		HIGHLIGHT_SETTING if chosen == ChosenClass.BANDIT else TRANS_SETTING
	
	$Background/VBoxContainer/StartButton.visible = true
	
	# -- Update character description boxes
	$Background/VBoxContainer/HBoxContainer2/Description/richTxtLblDesc.text=descriptions[chosen]['description']
	$Background/VBoxContainer/HBoxContainer2/ProsCons/richTxtLblProsCons.text=descriptions[chosen]['proscons']	
	$Background/VBoxContainer/HBoxContainer2/Abilities/RichTxtLblAbilities.text=descriptions[chosen]['abilities']

	

func _on_btn_fighter_pressed():
	select_class(ChosenClass.FIGHTER)


func _on_btn_sage_pressed():
	select_class(ChosenClass.SAGE)


func _on_btn_bandit_pressed():
	select_class(ChosenClass.BANDIT)


func _on_start_button_pressed():
	var char_to_load
	if curr_chosen_class == ChosenClass.FIGHTER:
		char_to_load=Global.characterDB["Fighter"]
	elif curr_chosen_class == ChosenClass.SAGE:
		char_to_load=Global.characterDB["Sage"]
	elif curr_chosen_class == ChosenClass.BANDIT:
		char_to_load=Global.characterDB["Bandit"]
	
	
	var params = {
		"player_character": char_to_load,
		"opponent": Global.characterDB["Goblin"]
	}
	Global.scene_change_params = params
	Game.change_scene_to_file("res://scenes/main_game_ui.tscn", params)
	
