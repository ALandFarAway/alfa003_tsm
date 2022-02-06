#include "acr_quest_i"
#include "acr_creature_i"


void main()
{   ACR_CreatureOnConversation();
    
	effect eTornado = EffectVisualEffect(VFX_IMP_TORNADO, FALSE);
	effect eSandstorm = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION, FALSE);
	object oCenter = GetWaypointByTag("WP_phalorm_globe_platform_green2");
	location lCenter = GetLocation(oCenter);
 	ActionSpeakString("Sand whirls up in a spiral from the center, engulfing all within 10 feet.", TALKVOLUME_TALK);
    object oDest = GetWaypointByTag("phalorm_earth_up_wp");
	int nCount = 0;
	object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
	while (oPC != OBJECT_INVALID) {
		nCount = nCount +1;
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eTornado, oPC, 5.0);
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eTornado, GetLocation(oPC), 5.0);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eTornado, oCenter, 5.0);
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eTornado, lCenter, 5.0);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eSandstorm, oPC, 5.0);
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSandstorm, GetLocation(oPC), 5.0);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eSandstorm, oCenter, 5.0);
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSandstorm, lCenter, 5.0);
		SendMessageToPC(oPC, "You are engulfed by a sand storm from the central shaft! You feel yourself lifted and pulled in, and then you are sinking, plunging through grit and earth.");
		DelayCommand(IntToFloat(nCount), AssignCommand(oPC, ActionJumpToObject(oDest, FALSE)));
		if(nCount > 10) {return;}
		oPC = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
	}
	
	DestroyObject(OBJECT_SELF, 5.0);
	
	
	 
   
	   	 
}