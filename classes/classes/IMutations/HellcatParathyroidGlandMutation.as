/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;

    public class HellcatParathyroidGlandMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.HellcatParathyroidGlandsIM);
            if (pTier >= 1){
                descS += "";
            }
            if (pTier >= 2){
                descS += ", ";
            }
            if (pTier >= 3){
                descS += ", ";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.HellcatParathyroidGlandsIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Hellcat Parathyroid Glands" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.HellcatParathyroidGlandsIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.HellcatParathyroidGlandsIM.requireHeartMutationSlot();
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.HellcatParathyroidGlandsIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Perk Max Level
        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 3;
        }

        //Mutations Buffs
        public function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            return pBuffs;
        }

        public function HellcatParathyroidGlandMutation() {
            super("Hellcat Parathyroid Glands IM", "Hellcat Parathyroid Glands", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}