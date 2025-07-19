extends Node

func build_weapon_db():
	Global.weaponDB["None"]=Weapon.new()
	Global.weaponDB["Dagger"]=Weapon.new("Dagger",3, Weapon.DamageType.SLASHING, "A standard six-inch all-purpose blade.")
	Global.weaponDB["Club"]=Weapon.new("Club",3, Weapon.DamageType.BLUDGEONING, "A weapon for applying blunt trauma.")
	Global.weaponDB["Shortspear"]=Weapon.new("Shortspear",3, Weapon.DamageType.PIERCING, "A three-foot pole with a sharp point at the end.")
