#include "acr_spawn_i"
#include "acr_quest_i"
#include "NW_I0_SPELLS"    
 
void main()
{
	object oSensor = GetObjectByTag("003_cr_scry_send", 0);
	
	ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_DEATH_WARD, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ENERGY, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_PROTECTION_FROM_GOOD, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	
	DelayCommand(40.0, ActionSpeakString("A surprise combatant? Amusing. Now die.", TALKVOLUME_TALK));
	DelayCommand(45.0, ActionCastSpellAtObject(SPELL_FLAME_ARROW, GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1), METAMAGIC_NONE, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	DelayCommand(60.0, ActionSpeakString("Well, if you won't die, then enjoy the show! *Casts at Bae'ithra", TALKVOLUME_TALK));
	DelayCommand(65.0, ActionCastSpellAtObject(SPELL_TASHAS_HIDEOUS_LAUGHTER, GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1), METAMAGIC_NONE, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	
	DelayCommand(90.0, ActionSpeakString("I think somebody needs to approach their role with more...vulnerability.*Casts into the melee", TALKVOLUME_TALK));
	DelayCommand(95.0, ActionCastSpellAtObject(SPELL_DISPEL_MAGIC, GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1), METAMAGIC_NONE, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	
	DelayCommand(120.0, ActionSpeakString("I wonder...did he bring a +1 to my little ceremony?", TALKVOLUME_TALK));
	DelayCommand(125.0, ActionCastSpellAtObject(3058, OBJECT_SELF, METAMAGIC_NONE, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	DelayCommand(126.0, AssignCommand(oSensor, ActionJumpToObject(OBJECT_SELF)));
	
	DelayCommand(150.0, ActionSpeakString("Prying eyes? *Laughs, long and hard* Who watches the watcher? That's a joke on me, isn't it. *Flings out his hand and an arrow of flame flies from it at the scrying sensor.", TALKVOLUME_TALK));
	DelayCommand(155.0, ActionCastSpellAtObject(SPELL_FLAME_ARROW, oSensor, METAMAGIC_NONE, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	
   }