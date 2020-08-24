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
			}}			
				
	
}