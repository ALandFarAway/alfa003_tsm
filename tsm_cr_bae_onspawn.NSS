//
//    Filename : tsm_cr_efreet_onspawn
//      Version : 0.1
//         Date : 7/18/22
//       Author : Wynna
//
//  Description
//  This script creates spawn effects for an ephreet lord.
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_spawn_i"
#include "x0_i0_talent"



void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}

void ActionCreateWynPlaceable(string sPlaceable, location lLocPlaceable)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, lLocPlaceable);
}

void ActionCreateWynEffect(string sObject, location lLocObject)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sObject, lLocObject);
}

void main() {

	ExecuteScript("acf_cre_onspawnin_buffed", OBJECT_SELF);
	object oBae = OBJECT_SELF;
	object oSensor = GetObjectByTag("003_cr_scry_send", 0);
	object oXavier = GetObjectByTag("003_cr_firegen_xavier", 0);
	object oDez = GetObjectByTag("003_cr_dragon_silver_dez", 0);
	object oNarrator = GetObjectByTag("003_cr_voice_xyz", 0);
	SetFirstName(oNarrator, "Bae'ithra");
	effect eAOE = EffectAreaOfEffect(AOE_MOB_DRAGON_FEAR);
    
	
	effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
	effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
	effect eEthereal = EffectEthereal();
	effect eGhost = EffectCutsceneGhost();	 	 		     	      
    effect eFreeze = EffectCutsceneImmobilize();
	SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 50, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCutScene, OBJECT_SELF, 45.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, OBJECT_SELF, 45.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, OBJECT_SELF, 45.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEthereal, OBJECT_SELF, 45.0);
	ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND));
		 	
	object oObsolete = CreateObject(OBJECT_TYPE_CREATURE, "003_pc_baeithra_2", GetLocation(OBJECT_SELF)); 
	effect eStorm = EffectVisualEffect(VFX_FNF_STORM, FALSE);
	effect eEmerge = EffectVisualEffect(VFX_CAST_SPELL_SPIRIT_EMERGE_GOOD, FALSE);
	
	ActionForceFollowObject(oObsolete, 0.5);
	AssignCommand(oNarrator, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStorm, oBae, 10.0));
	AssignCommand(oNarrator, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEmerge, oBae, 10.0));
	
	AssignCommand(oNarrator, ActionSpeakString("*As Bae'ithra falls, Silverwing whips around his head and bugles, then leaps into the sky with a clap of his great wings. Winds swirl, lightning flashes, and clouds form. The dragon bellows words of power.", TALKVOLUME_TALK));
	
	AssignCommand(oXavier, DelayCommand(5.0, ClearAllActions(TRUE)));
	AssignCommand(oXavier, DelayCommand(5.0, ActionSpeakString("An uninvited combatant! I do love a surprise entrant. Almost as much as a good joke. *Makes juggling motions before miming throwing a ball at Bae'ithra.", TALKVOLUME_TALK)));
	AssignCommand(oXavier, DelayCommand(6.0, ActionCastSpellAtObject(SPELL_TASHAS_HIDEOUS_LAUGHTER, oBae, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	
	AssignCommand(oNarrator, DelayCommand(10.0, ActionSpeakString("Ashera! *Bae'ithra claws at the bloodied dirt. He rolls over, and pushes himself up to his knees. He throws his arms wide, buckling backwards to the sky, and screams, in agonized laughter.", TALKVOLUME_TALK)));
	
	AssignCommand(oXavier, DelayCommand(15.0, ClearAllActions(TRUE)));
	AssignCommand(oXavier, DelayCommand(15.0, ActionSpeakString("Ashera? Did you bring a +1 to my little ceremony? Are there other gate crashers? Or just a voyeur?", TALKVOLUME_TALK)));
	AssignCommand(oXavier, DelayCommand(15.0, ActionCastSpellAtObject(3058, oXavier, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	
	 	 effect eEffect = GetFirstEffect(oSensor);
		 int nRep = 0;
		 while ((GetIsEffectValid(eEffect)) && (nRep < 10)) { 
			 DelayCommand(15.0, RemoveEffect(oSensor, eEffect));
			 eEffect = GetNextEffect(oSensor);
			 nRep ++;
			}
			
	AssignCommand(oNarrator, DelayCommand(20.0, ActionSpeakString("*Lurches to his feet, his back hunched, shaking, holding dislocated shoulders in a tight huddle.", TALKVOLUME_TALK)));
		
	AssignCommand(oObsolete, DelayCommand(29.0, ClearAllActions(TRUE)));
	AssignCommand(oObsolete, DelayCommand(30.0, ActionCastSpellAtObject(242, oXavier, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	
	AssignCommand(oXavier, DelayCommand(30.0, ClearAllActions(TRUE)));
	AssignCommand(oNarrator, DelayCommand(30.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze,oXavier, 40.0)));
    AssignCommand(oXavier, DelayCommand(31.0, ActionSpeakString("*Begins a mocking laugh, but chokes on it and a bellow he never finishes: 'MazeLord, I call upon you to--' *His jaw freezes, as does every movement.", TALKVOLUME_TALK)));
	
	
	AssignCommand(oObsolete, DelayCommand(34.0, ClearAllActions(TRUE)));
	AssignCommand(oObsolete, DelayCommand(35.0, ActionForceMoveToObject(oDez, TRUE, 2.0))); 
	AssignCommand(oNarrator, DelayCommand(35.0, ActionSpeakString("*Stumbles towards Silverwing, reaching out towards the dragon in supplication.", TALKVOLUME_TALK)));
	
	
	AssignCommand(oDez, DelayCommand(40.0, ClearAllActions(TRUE)));
	AssignCommand(oDez, DelayCommand(41.0, ActionSpeakString("*A taloned claw lashes out at Bae'ithra, shredding his armor across the back.", TALKVOLUME_TALK)));
	AssignCommand(oNarrator, DelayCommand(46.0, ActionSpeakString("*Silver scaled wings spread from Bae'ithra's shoulders, free of the armor's confinement.* I am ready, my kin! ", TALKVOLUME_TALK)));
	
	AssignCommand(oObsolete, DelayCommand(45.0, ClearAllActions(TRUE)));
	AssignCommand(oNarrator, DelayCommand(46.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, oObsolete)));
	AssignCommand(oNarrator, DelayCommand(46.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oObsolete)));
	AssignCommand(oNarrator, DelayCommand(46.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oObsolete)));
	AssignCommand(oNarrator, DelayCommand(46.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEthereal, oObsolete)));
	
	AssignCommand(oNarrator, DelayCommand(50.0, ActionCreateWynEffect("fx_portal_gen1", GetLocation(oBae))));
	AssignCommand(oDez, DelayCommand(50.0, ClearAllActions(TRUE)));
	AssignCommand(oDez, DelayCommand(51.0, ActionSpeakString("*A bright green glint appears at Silverwing's throat* THEN TAKE THIS AND GUARD HER FUTURE WELL. MY -- OUR -- OUR QUEEN AWAITS YOU.", TALKVOLUME_TALK)));
	AssignCommand(oNarrator, DelayCommand(56.0, ActionSpeakString("*Snatches up a basket of arrows and empties it, spinning, catching the green glint as it plummets from the dragon.", TALKVOLUME_TALK)));
	
	AssignCommand(oXavier, DelayCommand(55.0, ClearAllActions(TRUE)));
	AssignCommand(oXavier, DelayCommand(55.0, ActionSpeakString("Rest assured, lovely Ashera, I will find you again, wherever you watch from, after I give this unwelcome gladiator a final thumbs down.", TALKVOLUME_TALK)));
	AssignCommand(oXavier, DelayCommand(58.0, ActionCastSpellAtObject(SPELL_MAGIC_MISSILE, oSensor, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	
	
	}