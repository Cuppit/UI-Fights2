extends Node

var weaponDB = {"None":Weapon.new()}
var armorDB = {"None":Armor.new()}

## Function to build the globally accessible weaponDB.
func build_weapon_db():
	weaponDB["Dagger"]=Weapon.new("Dagger",3, Weapon.DamageType.SLASHING, "A standard six-inch all-purpose blade.")
	weaponDB["Club"]=Weapon.new("Club",3, Weapon.DamageType.BLUDGEONING, "A weapon for applying blunt trauma.")
	weaponDB["Shortspear"]=Weapon.new("Shortspear",3, Weapon.DamageType.PIERCING, "A three-foot pole with a sharp point at the end.")
	
func build_armor_db():
	armorDB["Gambeson"]=Armor.new("Gambeson")
