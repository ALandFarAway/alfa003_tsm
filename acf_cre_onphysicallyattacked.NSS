////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onphysicallyattacked
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnPhysicallyAttacked event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"

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
    ACR_CreatureOnPhysicallyAttacked();

    // Custom code goes here.
	object oAttacker = GetLastAttacker();
	string sAttacker = GetName(oAttacker);
	object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oAttacker);
	string sWeapon = GetName(oWeapon);
	object oArrows = GetItemInSlot(INVENTORY_SLOT_ARROWS, oAttacker);
	string sArrows = GetName(oArrows);
	object oBolts = GetItemInSlot(INVENTORY_SLOT_BOLTS, oAttacker);
	string sBolts = GetName(oBolts);
	object oBullets = GetItemInSlot(INVENTORY_SLOT_BULLETS, oAttacker);
	string sBullets = GetName(oBullets);
	object oProjectile;
	string sProjectile;
	
	SendMessageToAllDMs(GetName(oAttacker) + " is attacking " + GetName(OBJECT_SELF) + " with " + sWeapon + " in " + GetName(GetArea(oAttacker)));
	if(FindSubString(GetTag(GetArea(oAttacker)), "nw_cave_aq") != -1) 
		{object oSwimTrg = GetNearestObject(OBJECT_TYPE_TRIGGER, oAttacker, 1);
		 string sTrgTag = GetTag(oSwimTrg);
		 //SendMessageToAllDMs("Nearest trigger is " + sTrgTag);
		 if((FindSubString(sTrgTag, "Walkmesh") == -1) && (FindSubString(sTrgTag, "archive") == -1)) {
		 	 AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyAttackPenalty(2), oWeapon, 7.0);
			 AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyDamagePenalty(2), oWeapon, 7.0);
			 SendMessageToPC(oAttacker, "Water density makes fighting challenging and reduces a weapon's impact.");
			 if((FindSubString(sWeapon, "bow") != -1) || (FindSubString(sWeapon, "sling") != -1)  || (FindSubString(sWeapon, "Throwing") != -1)) {
				 AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyAttackPenalty(2), oWeapon, 7.0);
				 AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyDamagePenalty(2), oWeapon, 7.0);
				 SendMessageToPC(oAttacker, "Water density makes ranged weapons even more challenging than melee weapons and reduces their projectile impact.");
				 if(FindSubString(sAttacker, "Nionie") != -1) {
				 	SendMessageToPC(oAttacker, "Your specially designed arrows carry better through the water than standard arrows.");
					oProjectile = oArrows;
					}
				 else {
				 	 if(FindSubString(sWeapon, "crossbow") != -1) {
							//SendMessageToAllDMs("Attacking weapon is a crossbow.");
					    	SendMessageToPC(oAttacker, "Your bolts tumble in the water.");
							oProjectile = oBolts;
							}
						else if(FindSubString(sWeapon, "bow") != -1) {
							//SendMessageToAllDMs("Attacking weapon is a bow.");
					    	SendMessageToPC(oAttacker, "Your arrows tumble in the water.");
							oProjectile = oArrows;
							}
						else if(FindSubString(sWeapon, "sling") != -1) {
							//SendMessageToAllDMs("Attacking weapon is a sling.");
					    	SendMessageToPC(oAttacker, "Your bullets tumble in the water.");
							oProjectile = oBullets;
							}
						else if(FindSubString(sWeapon, "Throwing") != -1) {
							//SendMessageToAllDMs("Attacking weapon is a throwing axe.");
					    	SendMessageToPC(oAttacker, "Your axes tumble in the water.");
							}
					}		
				sProjectile = GetName(oProjectile);
				int nFireDmg = GetDamageDealtByType(DAMAGE_TYPE_FIRE);
				SendMessageToAllDMs(GetName(OBJECT_SELF) + " has taken " + IntToString(nFireDmg) + " points of damage from fire.");
			    effect eHeal = EffectHeal(nFireDmg);
				if((FindSubString(sProjectile, "Fire") != -1) || (FindSubString(sWeapon, "Fire") != -1) || (FindSubString(sProjectile, "Flame") != -1) || (FindSubString(sWeapon, "Flame") != -1)) {
				  	SendMessageToPC(oAttacker, "Your fiery projectile is doused.");
				 	ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF); 
					} 
					
				}
			 else if((FindSubString(sWeapon, "fire") != -1) || (FindSubString(sWeapon, "flame") != -1)) {
				  	SendMessageToPC(oAttacker, "Your fiery weapon is doused.");
				 	} 
			}
		}
		
	
		
	if(GetLocalInt(OBJECT_SELF, "Fleeing") == 1) 
		{ClearAllActions(TRUE);
		 ActionMoveAwayFromObject(GetLastAttacker(), TRUE, 200.0);
		
		}
		
	
}