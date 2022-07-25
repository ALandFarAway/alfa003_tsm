//OnDamage for all High Forest placeables 
//Wynna February 2022


#include "acr_placeable_i"

void main()
{
	ACR_PlaceableOnDamaged();
    object oDamager = GetLastDamager();
	object oPCOne = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1);
    object oPCTwo = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 2);
    object oPCThree = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 3);
    object oPCFour = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 4);
    object oPCFive = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 5);
    effect eKnockdown = EffectKnockdown();
	effect eStruck = EffectDamage(d4(1), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);			
	effect eSpark = EffectVisualEffect( VFX_IMP_FLAME_M, FALSE);
    effect eFireball = EffectVisualEffect ( VFX_FNF_FIREBALL, FALSE);
    effect eExplosion = EffectVisualEffect ( VFX_FNF_GAS_EXPLOSION_FIRE, FALSE);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE, FALSE);
    object oNPCOne = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, 1);
    object oNPCTwo = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, 2);
    object oInvisoCaster = GetObjectByTag("003_cr_invis_caster", 0);
	effect eDmg = EffectDamage(10, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL, TRUE);	
	object oOrb = GetObjectByTag("phalorm_orb_black", 0);
	
	if(GetTag(OBJECT_SELF)=="phalorm_orb_black") {
		
		int nHP = GetCurrentHitPoints(OBJECT_SELF);
		string sSpeak = "";
	    if((nHP <= 10) && (GetLocalInt(OBJECT_SELF, "SpeakStage") < 7)) {
			AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb));
			sSpeak = "*The orb explodes!";
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eExplosion, OBJECT_SELF, 3.0); 
	     	object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
			while(oPC != OBJECT_INVALID) {
			if(ReflexSave(oPC, 15, SAVING_THROW_TYPE_EVIL, OBJECT_SELF) == 0) {
				ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPC); 
	    	 	ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPC, 3.0); 
		     
			}
			oPC = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
			}
			SetLocalInt(OBJECT_SELF, "SpeakStage", 7);
			AssignCommand(oInvisoCaster, ActionSpeakString(sSpeak, TALKVOLUME_TALK));
			}
		else if((nHP < GetMaxHitPoints(OBJECT_SELF)/6) && (GetLocalInt(OBJECT_SELF, "SpeakStage") < 6)) {
			sSpeak = "*Small flames lick out of each crack in the orb, bathing it in an almost transparent aura of fire.";
			object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
			while(oPC != OBJECT_INVALID) {
			if(GetIsSkillSuccessful(oPC, SKILL_LISTEN, 15, FALSE)) {
				SendMessageToPC(oPC, "*A voice whispers from everywhere and nowhere, shifting around the confines of the room: 'Free. Free! FREE!'");
				}
			oPC = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
			}
			SetLocalInt(OBJECT_SELF, "SpeakStage", 6);
			AssignCommand(oInvisoCaster, ActionSpeakString(sSpeak, TALKVOLUME_TALK));
			}
		else if((nHP < GetMaxHitPoints(OBJECT_SELF)/5) && (GetLocalInt(OBJECT_SELF, "SpeakStage") < 5)) {
			sSpeak = "*The orb pulses red again...then again. It continues pulsing, the red flaring up inside, the cracks in it glowing an ominous, fiery hue with each pulsation.";
			object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
			while(oPC != OBJECT_INVALID) {
			if(GetIsSkillSuccessful(oPC, SKILL_LISTEN, 15, FALSE)) {
				SendMessageToPC(oPC, "*Amid the echoes in the room, you think you hear a murmer: 'Free me.'");
				}
			oPC = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
			}
			SetLocalInt(OBJECT_SELF, "SpeakStage", 5);
			AssignCommand(oInvisoCaster, ActionSpeakString(sSpeak, TALKVOLUME_TALK));
			}
		else if((nHP < GetMaxHitPoints(OBJECT_SELF)/4) && (GetLocalInt(OBJECT_SELF, "SpeakStage") < 4)) {
			sSpeak = "*Multiple cracks suddenly spider out across the facets of the orb. The red light at its heart pulses once.";
			SetLocalInt(OBJECT_SELF, "SpeakStage", 4);
			AssignCommand(oInvisoCaster, ActionSpeakString(sSpeak, TALKVOLUME_TALK));
			}
		else if((nHP < GetMaxHitPoints(OBJECT_SELF)/3) && (GetLocalInt(OBJECT_SELF, "SpeakStage") < 3)) {
			sSpeak = "*A crack appears in the black orb.";
			SetLocalInt(OBJECT_SELF, "SpeakStage", 3);
			AssignCommand(oInvisoCaster, ActionSpeakString(sSpeak, TALKVOLUME_TALK));
			}
		else if((nHP < GetMaxHitPoints(OBJECT_SELF)/2) && (GetLocalInt(OBJECT_SELF, "SpeakStage") < 2)) {
			sSpeak = "*A chip shatters off the orb, sending glittering black dust into the air. The red lights within it shrink to a burning point source at its heart.";
			SetLocalInt(OBJECT_SELF, "SpeakStage", 2);
			AssignCommand(oInvisoCaster, ActionSpeakString(sSpeak, TALKVOLUME_TALK));
			}
		else if(GetLocalInt(OBJECT_SELF, "SpeakStage") < 1){
			sSpeak = "*Red light swims across the black facets of the orb.";
			SetLocalInt(OBJECT_SELF, "SpeakStage", 1);
			AssignCommand(oInvisoCaster, ActionSpeakString(sSpeak, TALKVOLUME_TALK));
			}
			
		else {
			sSpeak = "*The orb pulses red.";
			AssignCommand(oInvisoCaster, ActionSpeakString(sSpeak, TALKVOLUME_TALK));
			
		}
	}
	
	
	
    if(GetTag(OBJECT_SELF) == "giant_crystal_source")
		{ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oDamager, 3.0); 
	     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSpark, OBJECT_SELF, 3.0); 
	     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFireball, OBJECT_SELF, 5.0); 
	     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eExplosion, OBJECT_SELF, 3.0); 
	     ActionSpeakString("The light within the giant crystal pulses. Cracks spread, and shards fly!", TALKVOLUME_TALK);
		 if(GetDistanceBetween(oPCOne, OBJECT_SELF) <= 30.0) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCOne); 
	    	 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCOne, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCOne, 3.0); 
	     }
		if(GetDistanceBetween(oPCTwo, OBJECT_SELF) <= 30.0) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCTwo); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCTwo, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCTwo, 3.0); 
	     }
		if(GetDistanceBetween(oPCThree, OBJECT_SELF) <= 30.0) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCThree); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCThree, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCThree, 3.0); 
	     }
		
		if(GetDistanceBetween(oPCFour, OBJECT_SELF) <= 30.0) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCFour); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCFour, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCFour, 3.0); 
	     }
		if(GetDistanceBetween(oPCFive, OBJECT_SELF) <= 30.0) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCFive); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCFive, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCFive, 3.0); 
	     }
		if(GetDistanceBetween(oNPCOne, OBJECT_SELF) <= 30.0) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oNPCOne); 
	    	 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oNPCOne, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oNPCOne, 3.0); 
	     }
		if(GetDistanceBetween(oNPCTwo, OBJECT_SELF) <= 30.0) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oNPCTwo); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oNPCTwo, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oNPCTwo, 3.0); 
	     }
		
		
		}
}			 			 