//OnUse for all Dean's Exam (deandragon) placeables 
//Wynna February 2009


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"
#include "acr_i"

void main()
{
	ACR_PlaceableOnPhysicalAttacked();

	object oAttacker = GetLastAttacker();
	//FrostHills Glacier Destroying Corrupted Portal
	if(GetTag(OBJECT_SELF)=="skng_gl_portal_orb") {
		ActionCastSpellAtObject(SPELL_ICE_STORM, oAttacker, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
	}			
				
	
}