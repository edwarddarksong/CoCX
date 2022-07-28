/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{

import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Scenes.SceneLib;

public class Weapon extends Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _type:String;
		private var _perks:Array;
		
		override public function get category():String {
			return CATEGORY_WEAPON_MELEE;
		}
		
		public function Weapon(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "", type:String = "") {
			super(id, shortName, name, longName, value, description);
			this._verb = verb;
			this._attack = attack;
			this._perk = perk;
			this._perks = perk ? perk.split(", ") : null;
			this._type = type;
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}
		
		public function get verb():String {
			if (hasSpecial(WP_STAFF) && game.player.hasPerk(PerkLib.StaffChanneling)) return 'shot';
			return _verb;
		}
		
		public function get attack():Number { return _attack; }
		
		public function get perk():String { return _perk; }

		public function get type():String { return _type; }
		
		public function get descBase():String { return _description; }
		
		override public function effectDescriptionParts():Array {
			var list:Array = super.effectDescriptionParts();
			// Type
			list.push([10,"Type: Melee Weapon"]);
			if (type != "") {
				list.push([15, "Weapon Class: " + type]);
			}
			// Attack
			list.push([20,"Attack: "+attack]);
			// Specials
			if (_perks) {
				list.push([60, "Specials: " + specInterpret()]);
			}
			return list;
		}

		public function hasSpecial(perk:String):Boolean {
			return _perks && _perks.indexOf(perk) >= 0;
		}
		
		public function specInterpret():String{
			var result:String = "";
			
			for (var i:int = 0; i < _perks.length; i++) {
				var spec:String = _perks[i];
				if (i > 0) result += ", ";
				result += WEAPON_PERK_NAMES[spec] || spec;
			}
			return result;
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if ((perk == WP_LARGE && !game.player.shield.isNothing && !game.player.hasPerk(PerkLib.GigantGrip)) || (perk == WP_MASSIVE && !game.player.shield.isNothing)) {
				if (doOutput) {
					outputText("Because this weapon requires the use of two hands, you have unequipped your shield. ");
					SceneLib.inventory.unequipShield();
				}
				return false;
			}
			if ((perk == WP_DUAL_LARGE || perk == WP_DUAL || perk == WP_DUAL_SMALL) && !game.player.shield.isNothing) {
				if (doOutput) {
					outputText("Because those weapons requires the use of two hands, you have unequipped your shield. ");
					SceneLib.inventory.unequipShield();
				}
				return false;
			}
			if (game.player.hasPerk(PerkLib.Rigidity)) {
				if (doOutput) outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
				return false;
			}
			return true;
		}
		
		override public function beforeEquip(doOutput:Boolean):Equipable {
			var temp:Array = perk.split(", ");
			var temp2:Array = [WP_LARGE, WP_MASSIVE, WP_DUAL, WP_DUAL_LARGE, WP_DUAL_SMALL]
			for each (var temp3:String in temp2){
				if (temp.indexOf(temp3) >= 0 && !game.player.shield.isNothing){
					if (temp3 == WP_LARGE) {
						if (game.player.hasPerk(PerkLib.GigantGrip)){
								break;
							}
						}
					SceneLib.inventory.unequipShield();
				}
			}/*
			if ((perk == "Large" && game.player.shield != ShieldLib.NOTHING && !game.player.hasPerk(PerkLib.GigantGrip))
			|| (perk == "Massive" && game.player.shield != ShieldLib.NOTHING)
			|| (perk == "Dual" && game.player.shield != ShieldLib.NOTHING)
			|| (perk == "Dual Large" && game.player.shield != ShieldLib.NOTHING)
			|| (perk == "Dual Small" && game.player.shield != ShieldLib.NOTHING)
			|| (game.player.shieldPerk == "Massive" && game.player.shield != ShieldLib.NOTHING && !game.player.hasPerk(PerkLib.GigantGrip))) {
				SceneLib.inventory.unequipShield();
			}*/
			if (game.player.weaponName == "fists" && game.player.hasNaturalWeapons()){
				game.flags[kFLAGS.FERAL_COMBAT_MODE] == 1;
			}
			else{
				if (game.flags[kFLAGS.FERAL_COMBAT_MODE] == 1 ) game.flags[kFLAGS.FERAL_COMBAT_MODE] = 0;
			}
			
			return super.beforeEquip(doOutput);
		}
	}
}
