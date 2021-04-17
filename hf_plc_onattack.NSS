//Onattack for Dean's Quest 2020 placeable
//Wynna August 2020


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"
#include "acr_i"

void main()
{
	ACR_PlaceableOnPhysicalAttacked();

	object oAttacker = GetLastAttacker();
	object oStoneTree = GetObjectByTag("rauvin_ruin_treestone_one", 0);
	object oStoneTreeWP = GetObjectByTag("undead_treant_one_wp", 0);
	object oStoneTreeTwo = GetObjectByTag("rauvin_ruin_treestone_two", 0);
	object oStoneTreeTwoWP = GetObjectByTag("undead_treant_two_wp", 0);
	object oStoneTreeThree;
	object oStoneTreeThreeWP;
	object oStoneTreeFour;
	object oStoneTreeFourWP;
	string sCreateCr = "abr_cr_pla_treant_undead";
	
	//High Forest Destroying Corrupted Portal
	if(GetTag(OBJECT_SELF)=="phalorm_orb_green") {
	 if(oStoneTree != OBJECT_INVALID) {
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oAttacker, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTree);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeWP), TRUE);
			}
			
		 else if(oStoneTreeTwo != OBJECT_INVALID) {
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oAttacker, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTreeTwo);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeTwoWP), TRUE);
			}
		}			
				
		if(GetTag(OBJECT_SELF)=="phalorm_orb_purple"){
	     oStoneTree = GetObjectByTag("aq_cave_treestone_one", 0);
		 oStoneTreeWP = GetObjectByTag("aq_cave_undead_treant_one_wp", 0);
		 oStoneTreeTwo = GetObjectByTag("aq_cave_treestone_two", 0);
		 oStoneTreeTwoWP = GetObjectByTag("aq_cave_undead_treant_two_wp", 0);
		 oStoneTreeThree= GetObjectByTag("aq_cave_treestone_three", 0);
		 oStoneTreeThreeWP = GetObjectByTag("aq_cave_undead_treant_three_wp", 0);
		 oStoneTreeFour = GetObjectByTag("aq_cave_treestone_four", 0);
		 oStoneTreeFourWP = GetObjectByTag("aq_cave_undead_treant_four_wp", 0);
		
	
	 	if(oStoneTree != OBJECT_INVALID) {
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oAttacker, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTree);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeWP), TRUE);
			}
			
		 else if(oStoneTreeTwo != OBJECT_INVALID) {
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oAttacker, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTreeTwo);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeTwoWP), TRUE);
			}
			
		else if(oStoneTreeThree != OBJECT_INVALID) {
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oAttacker, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTreeThree);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeThreeWP), TRUE);
			
			
			if(oStoneTreeFour != OBJECT_INVALID) {
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oAttacker, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTreeFour);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeFourWP), TRUE);
			}
			
		}
	}
}