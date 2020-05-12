//OnUse for all Dean's Exam (deandragon) placeables 
//Wynna February 2009


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"






void main()
{
	ACR_PlaceableOnSpellCastAt();
    object oCaster = GetLastSpellCaster();
	int nSpellId = GetSpellId();
	effect eFireball = EffectVisualEffect(VFX_DUR_FIREBALL, FALSE);
    object oCorpse = GetNearestObjectByTag("skng_plc_corpse_mh", OBJECT_SELF, 1);
	string sCreateAirCr = "003_cr_el_air";
	int nRandCreate = Random(5);
	if((nRandCreate = 3) || (nRandCreate = 4))
		{sCreateAirCr = "abr_cr_mephit_ice";}
	if(nRandCreate = 5)
		{sCreateAirCr = "003_slv_dq_a_creature";}
	
	
	//FrostHills Glacier Destroying Corrupted Portal
	if(GetTag(OBJECT_SELF)=="skng_gl_portal_orb") {
	    
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