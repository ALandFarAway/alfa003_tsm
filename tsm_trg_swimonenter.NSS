////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_trigger_i"
#include "acr_skills_i"
#include "acr_hazards_i"
#include "acr_movement_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() 
{
    ACR_TriggerOnEnter();
    object oEnterer = GetEnteringObject();
	
	SendMessageToAllDMs(GetName(oEnterer) + " has entered a swim trigger.");
	object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oEnterer);
	string sWeapon = GetName(oWeapon);
	EnterWater(OBJECT_SELF, oEnterer);
	//aquatic trigger mods for NPCs
	if(GetIsPC(oEnterer) == FALSE) {
		 object oSwimTrg = OBJECT_SELF;
		 string sTrgTag = GetTag(oSwimTrg);
		 //SendMessageToAllDMs("Nearest trigger is " + sTrgTag);
		 AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackPenalty(2), oWeapon);
		 AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamagePenalty(2), oWeapon);
		 if(GetHasSpell(SPELL_ORB_OF_FIRE|| SPELL_LESSER_ORB_OF_FIRE 
		|| SPELL_COMBUST || SPELL_DELAYED_BLAST_FIREBALL  || SPELL_ELEMENTAL_SHIELD 
		|| SPELL_FIRE_STORM || SPELL_FLAME_ARROW || SPELL_FLAME_LASH || SPELL_FLAME_WEAPON 
		|| SPELL_FIREBALL || SPELL_FIREBRAND || SPELL_FIREBURST 
		|| SPELL_BURNING_HANDS || SPELL_FLAME_STRIKE || SPELL_GREATER_FIREBURST 
		|| SPELL_INCENDIARY_CLOUD || SPELL_INFERNO || SPELL_INFINITE_RANGE_FIREBALL 
		|| 1056 || 1057 || SPELL_METEOR_SWARM || SPELL_METEOR_SWARM_TARGET_CREATURE 
		|| SPELL_METEOR_SWARM_TARGET_LOCATION || SPELL_METEOR_SWARM_TARGET_SELF
		|| SPELL_SHROUD_OF_FLAME || SPELL_WALL_OF_FIRE, oEnterer)) {
		
		 if(GetHasSpell(SPELL_SHROUD_OF_FLAME, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_SHROUD_OF_FLAME);
		 	}
		 if(GetHasSpell(SPELL_WALL_OF_FIRE, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_WALL_OF_FIRE);
		 	}
		 if(GetHasSpell(SPELL_METEOR_SWARM_TARGET_SELF, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_METEOR_SWARM_TARGET_SELF);
		 	}
		 if(GetHasSpell(SPELL_METEOR_SWARM_TARGET_LOCATION, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_METEOR_SWARM_TARGET_LOCATION);
		 	}
		 if(GetHasSpell(SPELL_METEOR_SWARM_TARGET_CREATURE, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_METEOR_SWARM_TARGET_CREATURE);
		 	}
		 if(GetHasSpell(SPELL_METEOR_SWARM, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_METEOR_SWARM);
		 	}
		 if(GetHasSpell(1057, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, 1057);
		 	}
		 if(GetHasSpell(1056, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, 1056);
		 	}
		 if(GetHasSpell(SPELL_GREATER_FIREBURST, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_GREATER_FIREBURST);
		 	}
		 if(GetHasSpell(SPELL_INFINITE_RANGE_FIREBALL, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_INFINITE_RANGE_FIREBALL);
		 	}
		 if(GetHasSpell(SPELL_INFERNO, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_INFERNO);
		 	}
		 if(GetHasSpell(SPELL_INCENDIARY_CLOUD, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_INCENDIARY_CLOUD);
		 	}
		 if(GetHasSpell(SPELL_GREATER_FIREBURST, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_GREATER_FIREBURST);
		 	}
		 if(GetHasSpell(SPELL_FLAME_STRIKE, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_FLAME_STRIKE);
		 	}
		 if(GetHasSpell(SPELL_BURNING_HANDS, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_BURNING_HANDS);
		 	}
		 if(GetHasSpell(SPELL_FIREBURST, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_FIREBURST);
		 	}
		 if(GetHasSpell(SPELL_FIREBRAND, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_FIREBRAND);
		 	}
		 if(GetHasSpell(SPELL_FIREBALL, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_FIREBALL);
		 	}
		 if(GetHasSpell(SPELL_FLAME_WEAPON, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_FLAME_WEAPON);
		 	}
		 if(GetHasSpell(SPELL_ELEMENTAL_SHIELD, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_ELEMENTAL_SHIELD);
		 	}
		 if(GetHasSpell(SPELL_FIRE_STORM, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_FIRE_STORM);
		 	}
		 if(GetHasSpell(SPELL_FLAME_ARROW, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_FLAME_ARROW);
		 	}
		 if(GetHasSpell(SPELL_FLAME_LASH, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_FLAME_LASH);
		 	}
		 if(GetHasSpell(SPELL_DELAYED_BLAST_FIREBALL, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_DELAYED_BLAST_FIREBALL);
		 	}
		 if(GetHasSpell(SPELL_COMBUST, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_COMBUST);
		 	}
		 if(GetHasSpell(SPELL_LESSER_ORB_OF_FIRE, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_LESSER_ORB_OF_FIRE);
		 	}
		 if(GetHasSpell(SPELL_ORB_OF_FIRE, oEnterer)) {
		  DecrementRemainingSpellUses(oEnterer, SPELL_ORB_OF_FIRE);
		 	}
		  
		}
	}
}