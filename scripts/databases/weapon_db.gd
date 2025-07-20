extends Node

var db = Global.weaponDB

func build_weapon_db():
	db["None"]=Weapon.new()
	db["Dagger"]=Weapon.new("Dagger",0,3, Weapon.DamageType.SLASHING, "A standard six-inch all-purpose blade.")
	db["Club"]=Weapon.new("Club",0,3, Weapon.DamageType.BLUDGEONING, "A weapon for applying blunt trauma.")
	db["Shortspear"]=Weapon.new("Shortspear",0,3, Weapon.DamageType.PIERCING, "A three-foot pole with a sharp point at the end.")
