extends Node
var db = Global.characterDB
var Attitude = GameCharacter.Attitude # convenience assignment for copypasting from GameCharacter script

func build_character_db():
	db["None"]=GameCharacter.new()
	db["Goblin"]=GameCharacter.new("Goblin",3,6,2,"Club","Jerkin", {Attitude.NEUTRAL:["The goblin stands ready.","The goblin shouts \"I'll eat your face!\"","It brandishes it's weapon menacingly.","The goblin is sizing you up."]\
					 ,Attitude.AGGRESSIVE:["The goblin looks ready to charge!","The goblin's shouting a battle cry!","You see a flash of bloodlust in it's eyes!"]\
					 ,Attitude.DEFENSIVE:["It's taking a defensive posture...","The goblin's anticipating your next move!"]\
					 ,Attitude.FAINTING:["The goblin's out of breath!","The goblin's struggling to stand!","It's looking rather weak!"]\
					 ,Attitude.DEFEATED:["The goblin collapses into a heap on the ground!","The goblin gurgles as it falls defeated!","You eradicated that goblin!"]})
