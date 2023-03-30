
//Wynna April 2021

 
#include "acr_items_i"

void main()
{	
	object oPC = GetModuleItemAcquiredBy();
	object oItem = GetModuleItemAcquired();
	
	int nWillSave = WillSave(oPC, 18, SAVING_THROW_TYPE_MIND_SPELLS, oItem);
	SetIdentified(oItem, TRUE);
	SendMessageToPC(oPC, "An illusion falls away from the crystal collar, revealing it as no more than a collar of greasy, wiry hair. A chunk of purplish crystal is embedded into a mat of the same hair that hangs pendant from the collar.");
	effect eIllusion = EffectVisualEffect(VFX_HIT_AOE_ILLUSION, FALSE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eIllusion, oPC, 5.0);
	effect eTransparent = EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT, FALSE);
	object oXavier = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_firegen_xavier_test", GetLocation(oPC));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTransparent, oXavier);
	object oSpotlight = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "circus_fx_spotlight", GetLocation(oXavier));
	SetLocalObject(oXavier, "oSpotlight", oSpotlight);
	DelayCommand(2.0, AssignCommand(oXavier, ActionSpeakString("Tah-DAH!", TALKVOLUME_TALK)));
	DelayCommand(4.0, AssignCommand(oXavier, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0, 2.0)));
	DelayCommand(6.0, AssignCommand(oXavier, ActionSpeakString("*Trails a finger along the rim of a sunburst diadem on his head.* Portals are so much easier now, with my new insight into these marvellous dead wizards. *Eyes gleam* And this one I made all for you.", TALKVOLUME_TALK)));
	DelayCommand(15.0, AssignCommand(oXavier, ActionSpeakString("*Chortles* A figment I am. A character in your drama...but so much more. So much! *Voice drops* And I have you, my devoted audience, to thank.", TALKVOLUME_TALK)));
	DelayCommand(25.0, AssignCommand(oXavier, ActionSpeakString("Are you still alive? *Diadem gleams as he twists his head to peer around the area, grinning manically.* If I'm speaking to you, you're still alive. Some of you. For now.", TALKVOLUME_TALK)));
	DelayCommand(35.0, AssignCommand(oXavier, ActionSpeakString("Of course, even if you're dead, I'd be speaking to you. *Pirouhettes with a flourish* The difference now is...if you're dead, you'll answer to me. *Giggles", TALKVOLUME_TALK)));
	DelayCommand(45.0, AssignCommand(oXavier, ActionSpeakString("*Bony finger suddenly to his lips, he stage whispers* I have a secret. When I remake this wondrous diadem...the Marches will answer to the Mazelord.", TALKVOLUME_TALK)));
	DelayCommand(55.0, AssignCommand(oXavier, ActionSpeakString("Until then, I'll enjoy this act. Two out of six. *Gestures slightly off to the side of the portal* I do hope those who went before choose one of the entertaining journeys. Until next time. Ta-ta!", TALKVOLUME_TALK)));
	DestroyObject(oXavier, 57.0);			  		  		 
	DestroyObject(oSpotlight, 60.0);
	DelayCommand(62.0, SendMessageToPC(oPC, "The collar crumbles to dust."));
	DestroyObject(OBJECT_SELF, 65.0);
					 
}			  