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
    if((GetTag(OBJECT_SELF) == "phalorm_orb_white") && (nSpellId == 1209 )){
		//object oPurpleGem = CreateObject(OBJECT_TYPE_ITEM, "003_it_phalorm_diamond", GetLocation(OBJECT_SELF));
		object oWhiteGem = CreateItemOnObject("003_it_phalorm_diamond", GetObjectByTag("phalorm_globe_white", 0));
		ActionSpeakString("A sparkling gem descends from out of the glowing orb. The gem drifts through a gap in the meshwork of the crystal globe beneath it and comes to a rest inside.", TALKVOLUME_TALK);
        //SendMessageToAllDMs("A phalorm Diamond Key was just created.");
		DestroyObject(GetObjectByTag("phalorm_orb_white_fx", 0), 1.0);
		DestroyObject(OBJECT_SELF, 2.0);
		}
		
	else if((GetTag(OBJECT_SELF)=="phalorm_orb_white") && (nSpellId != 547 ) && (oCaster != OBJECT_SELF)) {
	     oStoneTree = GetObjectByTag("aq_cave_treestone_one", 0);
		 oStoneTreeWP = GetObjectByTag("aq_cave_undead_treant_one_wp", 0);
		 oStoneTreeTwo = GetObjectByTag("aq_cave_treestone_two", 0);
		 oStoneTreeTwoWP = GetObjectByTag("aq_cave_undead_treant_two_wp", 0);
		 oStoneTreeThree= GetObjectByTag("aq_cave_treestone_three", 0);
		 oStoneTreeThreeWP = GetObjectByTag("aq_cave_undead_treant_three_wp", 0);
		 oStoneTreeFour = GetObjectByTag("aq_cave_treestone_four", 0);
		 oStoneTreeFourWP = GetObjectByTag("aq_cave_undead_treant_four_wp", 0);
		 if(GetLocalInt(OBJECT_SELF, "Treant") != 1) {
		 	ActionSpeakString("*Crackling and the rumbling of stone sounds from around the room, drawing all eyes to the eastern curve of the room. A pattern of cracks appears across the surface of a petrified tree, then explodes outward. As the dust settles, it reveals a moving creature. A treant -- or what had been a treant -- stands there, bark scarred, trunk splintered and dry. What had been wood shimmers with crystalline petrifications over mottled black and gray, as if centuries of rot had been crystallized. It thrashes. A clattering like a storm through bones sounds over a wail of anger and animosity.", TALKVOLUME_TALK);
			SetLocalInt(OBJECT_SELF, "Treant", 1);
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
			
			ActionCastSpellAtObject(SPELL_STONEHOLD, oCaster, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE); 
			DestroyObject(oStoneTreeFour);
			CreateObject(OBJECT_TYPE_CREATURE, sCreateCr, GetLocation(oStoneTreeFourWP), TRUE);
			}
			
		}
	}
	
}