//OnUse for all Dean's Exam (deandragon) placeables 
//Wynna February 2009


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"






void main()
{
	ACR_PlaceableOnSpellCastAt();
    object oCaster = GetLastSpellCaster();
	int nSpellId = GetLastSpell();
	string sCreateCr = "abr_cr_pla_treant_undead";
	object oStoneTree;
	object oStoneTreeWP;
	object oStoneTreeTwo;
	object oStoneTreeTwoWP;
	object oStoneTreeThree;
	object oStoneTreeThreeWP;
	object oStoneTreeFour;
	object oStoneTreeFourWP;
		
		
	
	//High Forest Phalorm Spheres
	if((GetTag(OBJECT_SELF) == "phalorm_orb_green") && ((nSpellId == SPELL_ORB_OF_ACID ) || (nSpellId == SPELL_ORB_OF_COLD )|| (nSpellId == SPELL_ORB_OF_ELECTRICITY ) || (nSpellId == SPELL_ORB_OF_FIRE ))){
		object oGreenGem = CreateObject(OBJECT_TYPE_ITEM, "003_it_phalorm_emerald", GetLocation(OBJECT_SELF));
		SendMessageToAllDMs("A phalorm Emerald Sphere was just created.");
		DestroyObject(OBJECT_SELF, 20.0);
		}
		
	
	else if((GetTag(OBJECT_SELF)=="phalorm_orb_green")  && (oCaster != OBJECT_SELF)) {
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
	
	//ActionSpeakString("SpellID = " + IntToString(nSpellId), TALKVOLUME_TALK);
    if((GetTag(OBJECT_SELF) == "phalorm_orb_white") && (nSpellId >= 1197 ) && (nSpellId <= 1209) && (nSpellId != 1200) && (nSpellId != 1201) && (nSpellId != 1202)){
		//object oPurpleGem = CreateObject(OBJECT_TYPE_ITEM, "003_it_phalorm_diamond", GetLocation(OBJECT_SELF));
		object oWhiteGem = CreateItemOnObject("003_it_phalorm_diamond", GetObjectByTag("phalorm_globe_white", 0));
		ActionSpeakString("A sparkling gem descends from out of the glowing orb. The gem drifts through a gap in the meshwork of the crystal globe beneath it and comes to a rest inside.", TALKVOLUME_TALK);
        //SendMessageToAllDMs("A phalorm Diamond Key was just created.");
		DestroyObject(GetObjectByTag("phalorm_orb_white_fx", 0), 1.0);
		DestroyObject(OBJECT_SELF, 2.0);
		}
		
	else if((GetTag(OBJECT_SELF)=="phalorm_orb_white") && (nSpellId != 547 ) && (oCaster != OBJECT_SELF)) {
	     sCreateCr = "abr_cr_pla_treant_crystal";
		 oStoneTree = GetObjectByTag("aq_cave_treestone_one", 0);
		 oStoneTreeWP = GetObjectByTag("aq_cave_undead_treant_one_wp", 0);
		 oStoneTreeTwo = GetObjectByTag("aq_cave_treestone_two", 0);
		 oStoneTreeTwoWP = GetObjectByTag("aq_cave_undead_treant_two_wp", 0);
		 oStoneTreeThree= GetObjectByTag("aq_cave_treestone_three", 0);
		 oStoneTreeThreeWP = GetObjectByTag("aq_cave_undead_treant_three_wp", 0);
		 oStoneTreeFour = GetObjectByTag("aq_cave_treestone_four", 0);
		 oStoneTreeFourWP = GetObjectByTag("aq_cave_undead_treant_four_wp", 0);
		 if(GetLocalInt(OBJECT_SELF, "Treant") == 0) {
		 	ActionSpeakString("*Crackling and rumbling of stone sounds. A pattern of cracks appears across the surface of a stone tree, then explodes outward. As the dust settles, it reveals a moving being, a treant larger than most, bark glittering, leaves made of crystal planes. What had been wood shimmers with facets, as if a living treant had been turned to diamond. It is both beautiful and terrible.", TALKVOLUME_TALK);
			SetLocalInt(OBJECT_SELF, "Treant", 1);
			}
	 	if(GetLocalInt(OBJECT_SELF, "Treant") == 1) {
		 	ActionSpeakString("*A second crystal treant bursts out of the dusty, cob-webbed stone that had hidden it.", TALKVOLUME_TALK);
			SetLocalInt(OBJECT_SELF, "Treant", 2);
			}
	 	if(GetLocalInt(OBJECT_SELF, "Treant") == 2) {
		 	ActionSpeakString("*First one, then two crystal treants explode into movement amid the schrapnel of the stone that had encased them.", TALKVOLUME_TALK);
			SetLocalInt(OBJECT_SELF, "Treant", 2);
			}
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
			
			DestroyObject(oStoneTreeFour);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeFourWP), TRUE);
			}
			
		}
	}
	
}