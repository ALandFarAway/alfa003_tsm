#include "acr_spawn_i"
#include "acr_quest_i"
#include "NW_I0_SPELLS"
#include "ginc_item"
 
void main()
{
	object oSensor = GetObjectByTag("abr_cr_scry_send_xavier", 0);
			 
	IdentifyEquippedItems();
    IdentifyInventory();
	ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_DEATH_WARD, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ENERGY, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_PROTECTION_FROM_GOOD, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_GREATER_INVISIBILITY, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	
	
	/*SpeakString("Well would you look at that. I pop by on a whim to check on a suddenly unreachable portal and what do I find but my missing orc tribe? And here I thought I'd left them in my other cassock.", TALKVOLUME_TALK);
	DelayCommand(6.0, AssignCommand(oSayen, ActionCastSpellAtObject(3089, OBJECT_SELF, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));	
	DelayCommand(12.0, ClearAllActions(TRUE));
	DelayCommand(12.0, ActionSpeakString("*Holds up a hand that sprouts flames that arc around him protectively.* No, really I can't stay. Even though you ask so nicely. Wish I could. This looks like the start of Act Three and it always gets *so* exciting in the third act." , TALKVOLUME_TALK));
	DelayCommand(18.0, ActionSpeakString("Loristias, would you bring me something from the kitchen? Time for dinner and a show. *Vanishes" , TALKVOLUME_TALK));
	DestroyObject(OBJECT_SELF, 20.0);*/
	}