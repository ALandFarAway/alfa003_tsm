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
	string sCreateCr = "abr_cr_pla_treant_undead";
	object oStoneTree;
	object oStoneTreeWP;
	object oStoneTreeTwo;
	object oStoneTreeTwoWP;
	object oStoneTreeThree;
	object oStoneTreeThreeWP;
	object oStoneTreeFour;
	object oStoneTreeFourWP;
		
	
	//High Forest Destroying Corrupted Portals
	if((GetTag(OBJECT_SELF)=="phalorm_orb_green")  && (oCaster != OBJECT_SELF)) {
	     oStoneTree = GetObjectByTag("rauvin_ruin_treestone_one", 0);
		 oStoneTreeWP = GetObjectByTag("undead_treant_one_wp", 0);
		 oStoneTreeTwo = GetObjectByTag("rauvin_ruin_treestone_two", 0);
		 oStoneTreeTwoWP = GetObjectByTag("undead_treant_two_wp", 0);
		 if(oStoneTree != OBJECT_INVALID) {
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oCaster, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTree);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeWP), TRUE);
			}
			
		 else if(oStoneTreeTwo != OBJECT_INVALID) {
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oCaster, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTreeTwo);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeTwoWP), TRUE);
			}
	}
	
	if((GetTag(OBJECT_SELF)=="phalorm_orb_purple")  && (oCaster != OBJECT_SELF)) {
	     oStoneTree = GetObjectByTag("aq_cave_treestone_one", 0);
		 oStoneTreeWP = GetObjectByTag("aq_cave_undead_treant_one_wp", 0);
		 oStoneTreeTwo = GetObjectByTag("aq_cave_treestone_two", 0);
		 oStoneTreeTwoWP = GetObjectByTag("aq_cave_undead_treant_two_wp", 0);
		 oStoneTreeThree= GetObjectByTag("aq_cave_treestone_three", 0);
		 oStoneTreeThreeWP = GetObjectByTag("aq_cave_undead_treant_three_wp", 0);
		 oStoneTreeFour = GetObjectByTag("aq_cave_treestone_four", 0);
		 oStoneTreeFourWP = GetObjectByTag("aq_cave_undead_treant_four_wp", 0);
		
	
	 	if(oStoneTree != OBJECT_INVALID) {
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oCaster, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTree);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeWP), TRUE);
			}
			
		 else if(oStoneTreeTwo != OBJECT_INVALID) {
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oCaster, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTreeTwo);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeTwoWP), TRUE);
			}
			
		else if(oStoneTreeThree != OBJECT_INVALID) {
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oCaster, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTreeThree);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeThreeWP), TRUE);
			
			
		if(oStoneTreeFour != OBJECT_INVALID) {
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oCaster, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTreeFour);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeFourWP), TRUE);
			}
			
		}
	}
	
}