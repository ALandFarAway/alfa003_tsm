//OnUse for all Dean's Exam (deandragon) placeables 
//Wynna February 2009


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"




void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}

void main()
{
	ACR_PlaceableOnSpellCastAt();
    object oCaster = GetLastSpellCaster();
	int nSpellId = GetSpellId();
	effect eFireball = EffectVisualEffect(VFX_DUR_SPELL_INCENDIARY_CLOUD, FALSE);
    object oCorpse = GetNearestObjectByTag("skng_plc_corpse_mh", OBJECT_SELF, 1);
	string sCreateAirCr = "010_cr_elementalairelder";
	effect eSteamDmg = EffectDamage(d6(1),DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL, FALSE);
	
		
	//Glacier Trail Phalorm Sphere
	if((GetTag(OBJECT_SELF) == "phalorm_orb_blue") && ((nSpellId == SPELL_ORB_OF_ACID ) || (nSpellId == SPELL_ORB_OF_COLD )|| (nSpellId == SPELL_ORB_OF_ELECTRICITY ) || (nSpellId == SPELL_ORB_OF_FIRE ))){
		object oBlueGem = CreateObject(OBJECT_TYPE_ITEM, "003_it_phalorm_sapphire", GetLocation(OBJECT_SELF));
		SendMessageToAllDMs("A phalorm Sapphire Sphere was just created.");
		DestroyObject(OBJECT_SELF, 20.0);
		}	
	else if(GetTag(OBJECT_SELF) == "phalorm_orb_blue") {
		ActionCastSpellAtObject(SPELL_ICE_STORM, oCaster, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
		CreateObject(OBJECT_TYPE_CREATURE, sCreateAirCr, GetLocation(OBJECT_SELF), TRUE);
		} 
		
		
	if(GetTag(OBJECT_SELF) == "abr_plc_snow_melt_pillar") {
		effect eBurst = EffectVisualEffect(VFX_FNF_SOUND_BURST, FALSE);
        effect eExplode = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION, FALSE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplode, OBJECT_SELF, 3.0);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBurst, OBJECT_SELF, 5.0);
		CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_un_zombie_frostmourngiant", GetLocation(OBJECT_SELF), TRUE);
		DelayCommand(2.0, ActionCreateCreature("abr_cr_un_zombie_frostmourngiant", GetLocation(OBJECT_SELF)));
		DestroyObject(OBJECT_SELF, 3.0);
		} 
		

		
	//FrostHills Glacier Destroying Corrupted Portal
	if((GetTag(OBJECT_SELF)=="skng_gl_portal_orb") && (oCaster != OBJECT_SELF)) {
	    
		if(nSpellId == SPELL_COMBUST ||nSpellId ==  SPELL_DELAYED_BLAST_FIREBALL  || nSpellId == SPELL_ELEMENTAL_SHIELD || nSpellId == SPELL_FIRE_STORM || nSpellId == SPELL_FLAME_ARROW || nSpellId == SPELL_FLAME_LASH || nSpellId == SPELL_FLAME_WEAPON || nSpellId == SPELL_FIREBALL || nSpellId == SPELL_FIREBRAND || nSpellId == SPELL_FIREBURST 
			|| nSpellId == SPELL_BURNING_HANDS || nSpellId == SPELL_FLAME_STRIKE || nSpellId == SPELL_GREATER_FIREBURST  || nSpellId == SPELL_INCENDIARY_CLOUD ||nSpellId == SPELL_INFERNO || nSpellId == SPELL_INFINITE_RANGE_FIREBALL 
			|| nSpellId == 1056 || nSpellId == 1057 || nSpellId == SPELL_METEOR_SWARM || nSpellId == SPELL_METEOR_SWARM_TARGET_CREATURE || nSpellId == SPELL_METEOR_SWARM_TARGET_LOCATION || nSpellId == SPELL_METEOR_SWARM_TARGET_SELF
			|| nSpellId == SPELL_SHROUD_OF_FLAME || nSpellId == SPELL_WALL_OF_FIRE)
				{ActionCastSpellAtObject(SPELL_FIRE_STORM, OBJECT_SELF, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
				 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireball, OBJECT_SELF, 10.0);
				 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFireball, OBJECT_SELF));
				 
				 DestroyObject(OBJECT_SELF, 10.0);
				
				}
		
		else {
		ActionCastSpellAtObject(SPELL_ICE_STORM, oCaster, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
		CreateObject(OBJECT_TYPE_CREATURE, sCreateAirCr, GetLocation(oCorpse), TRUE);
		}
	
	}
	
}