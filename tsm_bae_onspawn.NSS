#include "acr_spawn_i"
#include "acr_quest_i"
 
void main()
{
		object oSilverwing = GetObjectByTag("003_cr_dragon_silver_dez", 0);
		object oBae = OBJECT_SELF;
		DelayCommand(10.0, ClearAllActions(TRUE));
		DelayCommand(10.0, ActionSpeakString("*Goes down repeatedly, each time pushing himself back up to his feet, fighting on", TALKVOLUME_TALK));
		DelayCommand(20.0, ClearAllActions(TRUE));
		DelayCommand(20.0, ActionSpeakString("*Falls, buckling backwards, arms outspread beneath the sky", TALKVOLUME_TALK));
		DelayCommand(20.0, ActionSpeakString("I am ready, my kin! *Cries out", TALKVOLUME_TALK));
		AssignCommand(oSilverwing, DelayCommand(30.0, ClearAllActions(TRUE)));
		AssignCommand(oSilverwing, DelayCommand(30.0, ActionSpeakString("*Now! Now I see hope for her salvation! *Claws at a large green crystal embedded in his neck.", TALKVOLUME_TALK)));
		AssignCommand(oSilverwing, DelayCommand(30.0, ActionCastSpellAtObject(SPELL_SUPERIOR_RESISTANCE, oBae, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
		effect ePoly = EffectPolymorph(POLYMORPH_TYPE_WYRMLING_WHITE, FALSE, FALSE);
		DelayCommand(35.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oBae, 1800.0));
		
	
   }