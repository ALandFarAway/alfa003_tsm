
//Wynna April 2021

 
#include "acr_items_i"

void main()
{	
	object oPC = GetModuleItemAcquiredBy();
	object oItem = GetModuleItemAcquired();
	effect eFreeze = EffectCutsceneImmobilize();
	object oPortal = GetObjectByTag("alfa_portal_plc_wyv", 0);
	
	int nWillSave = WillSave(oPC, 18, SAVING_THROW_TYPE_MIND_SPELLS, oItem);
	SetIdentified(oItem, TRUE);
	SendMessageToPC(oPC, "An illusion falls away from the crystal collar, revealing it as no more than a collar of greasy, wiry hair. A chunk of purplish crystal is embedded into a mat of the same hair that hangs pendant from the collar.");
	effect eIllusion = EffectVisualEffect(VFX_HIT_AOE_ILLUSION, FALSE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eIllusion, oPC, 5.0);
	effect eTransparent = EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT, FALSE);
	object oXavier = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_firegen_xavier_test", GetLocation(oPortal));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTransparent, oXavier);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze, oXavier);
	ChangeToStandardFaction(oXavier, STANDARD_FACTION_COMMONER);
	object oSpotlight = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "circus_fx_spotlight", GetLocation(oXavier));
	SetLocalObject(oXavier, "oSpotlight", oSpotlight);
	DelayCommand(2.0, AssignCommand(oXavier, ActionSpeakString("Tah-DAH!", TALKVOLUME_TALK)));
	DelayCommand(4.0, AssignCommand(oXavier, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0, 2.0)));
	DelayCommand(10.0, AssignCommand(oXavier, ActionSpeakString("*Trails a finger along the rim of a sunburst diadem on his head.* Portals are so much easier now, with my new insight into these marvellous dead conjurers. *Eyes gleam* And this one I made all for you.", TALKVOLUME_TALK)));
	DelayCommand(25.0, AssignCommand(oXavier, ActionSpeakString("*Chortles* A figment I am. A character in your drama...but so much more. So much! *Voice drops* And I have you, my devoted audience, to thank.", TALKVOLUME_TALK)));
	DelayCommand(40.0, AssignCommand(oXavier, ActionSpeakString("Are you still alive? *Diadem casts a shadow across his face, deepening the shadows of his eye sockets, like a skull's.* If I'm speaking to you, you're still alive. Some of you. For now. I do hope a little chewed on, though, by what remains of your big silver-scaled friend.", TALKVOLUME_TALK)));
	DelayCommand(55.0, AssignCommand(oXavier, ActionSpeakString("Of course, even if you're dead, I'd be speaking to you. *Pirouhettes with a flourish* The difference now is...if you're dead, you'll answer to me. *Giggles", TALKVOLUME_TALK)));
	DelayCommand(70.0, AssignCommand(oXavier, ActionSpeakString("*Bony finger suddenly to his lips, he stage whispers* I have a secret. When I remake this wondrous diadem...the Marches will answer to the Mazelord.", TALKVOLUME_TALK)));
	DelayCommand(85.0, AssignCommand(oXavier, ActionSpeakString("Until then, I'll enjoy this act. Two out of six. *Gestures slightly off to the side of the portal* I do hope those who went before choose one of the entertaining journeys. Until next time. Ta-ta!", TALKVOLUME_TALK)));
	DelayCommand(100.0, AssignCommand(oXavier, ActionSpeakString("*Vanishes", TALKVOLUME_TALK)));
	DelayCommand(100.0, SetImmortal(oXavier, FALSE));
	DestroyObject(oXavier, 102.0);			  		  		 
	DelayCommand(102.0, AssignCommand(oPC, ActionSpeakString("*Watches as the collar crumbles to dust.", TALKVOLUME_TALK)));
	DelayCommand(102.0, SendMessageToPC(oPC, "The collar crumbles to dust."));
	DestroyObject(oSpotlight, 104.0);
	DestroyObject(OBJECT_SELF, 105.0);
	 				 
}			  