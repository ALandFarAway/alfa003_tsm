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
	string sCreateCr = "";
	effect eBeamGreen = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	object oInvisoCaster = GetObjectByTag("003_cr_invis_caster", 0);
	
	if(GetTag(OBJECT_SELF)=="phalorm_orb_black") {
		SetFirstName(oInvisoCaster, "Black Orb");
		ActionSpeakString("A green beam lances out at " + GetName(oAttacker) + ".", TALKVOLUME_TALK);
		effect eFireI = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 100);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFireI, OBJECT_SELF);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreen, oAttacker, 3.0);
		AssignCommand(oInvisoCaster, ActionCastSpellAtObject(SPELL_DISINTEGRATE, oAttacker, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	}
	
	
	
	
	object oStoneTree = GetObjectByTag("rauvin_ruin_treestone_one", 0);
	object oStoneTreeWP = GetObjectByTag("undead_treant_one_wp", 0);
	object oStoneTreeTwo = GetObjectByTag("rauvin_ruin_treestone_two", 0);
	object oStoneTreeTwoWP = GetObjectByTag("undead_treant_two_wp", 0);
	object oStoneTreeThree;
	object oStoneTreeThreeWP;
	object oStoneTreeFour;
	object oStoneTreeFourWP;
	
	//High Forest Destroying Corrupted Portal
	if(GetTag(OBJECT_SELF)=="phalorm_orb_green") {
	 if(oStoneTree != OBJECT_INVALID) {
			sCreateCr = "abr_cr_pla_treant_undead";
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
		 if(GetLocalInt(OBJECT_SELF, "Treant") != 1) {
		 	ActionSpeakString("*Crackling and the rumbling of stone sounds from around the room, drawing all eyes to the eastern curve of the room. A pattern of cracks appears across the surface of a petrified tree, then explodes outward. As the dust settles, it reveals a moving creature. A treant -- or what had been a treant -- stands there, bark scarred, trunk splintered and dry. What had been wood shimmers with crystalline petrifications over mottled black and gray, as if centuries of rot had been crystallized. It thrashes. A clattering like a storm through bones sounds over a wail of anger and animosity.", TALKVOLUME_TALK);
			SetLocalInt(OBJECT_SELF, "Treant", 1);
			}
	
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