extends Control



var player: GameCharacter




func _ready():
	#generate the game resources as defined in scripts
	Global.build_weapon_db()
	Global.build_armor_db()
	
	player = GameCharacter.new()
	player.print_health()
