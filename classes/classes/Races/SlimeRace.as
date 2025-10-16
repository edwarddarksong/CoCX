package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;

public class SlimeRace extends Race {
	public static const SlimeSkinColors:/*String*/Array = ["green", "magenta", "blue", "cerulean", "emerald", "pink", "milky white"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Human",
        /*Eyes*/		"Human",
        /*Face*/		"Human",
        /*Gills*/		"Human",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Human",
        /*RearBody*/	"Human",
        /*Skin*/		"Human",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Human"];
	
	public function SlimeRace(id:int) {
		super("Slime", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.skinColor1(ANY(SlimeSkinColors), +1, -1000)
				.hairType(Hair.GOO, +1)
				.armType(Arms.GOO, +1)
				.legType(LowerBody.GOO, +3)
				.rearType(RearBody.METAMORPHIC_GOO, +2)
				.customRequirement("skin", "slimy goo skin", function (body:BodyData):Boolean {
					return body.player.isGooSkin() && body.skinBaseAdj == "slimy"
				}, +1)
				.hasStatusEffect(StatusEffects.SlimeCraving, "Slime Craving", +1)
				.hasPerk(PerkLib.SlimeCore, +1)
				.hasPerk(PerkLib.RoyalSlimeJelly, +5)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addConditionedScores(function (body:BodyData):Boolean {
			return body.player.isGooSkin() && body.skinBaseAdj == "slimy"
		}, "slimy goo skin;")
				.faceType(Face.HUMAN, +1)
				.eyeType(Eyes.HUMAN, +1)
				.earType(ANY(Ears.HUMAN, Ears.ELFIN), +1)
				.height(GREATER_THAN(107), +1)
				.hasVagina(+1)
				.noAntennae(+1)
				.noWings(+1)
				.noGills(+1);
		
		addMutation(IMutationsLib.SlimeMetabolismIM);
		addMutation(IMutationsLib.SlimeFluidIM);
		
		buildTier(10, "Slime")
				.namesMaleFemale("Slime boi", "Slime Girl")
				.buffs({
					"tou.mult": +1.00,
					"spe.mult": -0.40,
					"lib.mult": +1.05
				})
				.end();
		
		buildTier(16, "Elder Slime")
				.buffs({
					"tou.mult": +1.25,
					"spe.mult": -0.50,
					"lib.mult": +1.65
				})
				.end();
		
		buildTier(24, "Queen Slime")
				.buffs({
					"tou.mult": +4.25,
					"spe.mult": -0.75,
					"lib.mult": +3.65,
					"str.mult": +3.65
				})
				.requirePerk(PerkLib.TransformationImmunity2)
				.end();
	}
}
}
