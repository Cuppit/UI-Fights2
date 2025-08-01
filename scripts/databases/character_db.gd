extends Node
var db = Global.characterDB
var Attitude = GameCharacter.Attitude # convenience assignment for copypasting from GameCharacter script
var Stat = GameCharacter.Stat

func build_character_db():
	db["None"]=GameCharacter.new()
	db["Goblin"]=GameCharacter.new("Goblin",{Stat.STR:2,Stat.DEX:4,Stat.CON:2,Stat.INT:1,Stat.BELT_CAP:1},"Club","Jerkin","Side Satchel", {Attitude.NEUTRAL:["The goblin stands ready.","The goblin shouts \"I'll eat your face!\"","It brandishes it's weapon menacingly.","The goblin is sizing you up."]\
					 ,Attitude.AGGRESSIVE:["The goblin looks ready to charge!","The goblin's shouting a battle cry!","You see a flash of bloodlust in it's eyes!"]\
					 ,Attitude.DEFENSIVE:["It's taking a defensive posture...","The goblin's anticipating your next move!"]\
					 ,Attitude.FAINTING:["The goblin's out of breath!","The goblin's struggling to stand!","It's looking rather weak!"]\
					 ,Attitude.DEFEATED:["The goblin collapses into a heap on the ground!","The goblin gurgles as it falls defeated!","You eradicated that goblin!"]},10,10)
	db["Goblin"].gain_item("Healing Salve")
	db["Goblin"].money = 10
	
	db["Fighter"]=GameCharacter.new("Fighter",{Stat.STR:5,Stat.DEX:2,Stat.CON:4,Stat.INT:3,Stat.BELT_CAP:1},"Greatsword","Gambeson","Side Satchel", {Attitude.NEUTRAL:["The goblin stands ready.","The goblin shouts \"I'll eat your face!\"","It brandishes it's weapon menacingly.","The goblin is sizing you up."]\
					 ,Attitude.AGGRESSIVE:["The warrior looks ready to charge!","The warrior postures aggressively!","You see a flash of bloodlust in the warrior's eyes!"]\
					 ,Attitude.DEFENSIVE:["A defensive posture's exhibited.","The warrior's anticipating your next move!"]\
					 ,Attitude.FAINTING:["The warrior's out of breath!","The warrior's struggling to stand!","The warrior appears weakened!"]\
					 ,Attitude.DEFEATED:["The warrior collapses into a heap on the ground!","The warrior falls defeated!","You defeated the warrior!"]})

	for x in range(5):
		print("IN character_db.gd, giving 'Fighter' five salves.  Adding salve #)",x,":")
		db["Fighter"].gain_item("Useless Item") if x > 2 else null
		db["Fighter"].gain_item("Healing Salve")

	db["Fighter"].gain_item("Shortspear",GameCharacter.InvType.WEAPON)
	db["Fighter"].gain_item("Jerkin",GameCharacter.InvType.ARMOR)
	db["Fighter"].gain_item("Belt of Strength",GameCharacter.InvType.ACCESSORY)
	
	
	

	db["Sage"]=GameCharacter.new("Sage",{Stat.STR:3,Stat.DEX:3,Stat.CON:2,Stat.INT:5,Stat.BELT_CAP:1},"Greatsword","Gambeson","Side Satchel")
	
	
	db["Bandit"]=GameCharacter.new("Bandit",{Stat.STR:3,Stat.DEX:5,Stat.CON:4,Stat.INT:3,Stat.BELT_CAP:1},"Dagger","Gambeson","Side Satchel")
