////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onspawnin
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnSpawnIn event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//    2010/11/17  AcadiusLost - Autodisabled flocking on creatures without a "parent" spawn point.
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
    ACR_CreatureOnSpawnIn();
	
	
	//animation code
	if (GetLocalInt(OBJECT_SELF,"USE_IMMOBILE_AMBIENT_ANIM")==1)
		{
		float fRand=IntToFloat(d6(3));
		DelayCommand(fRand,ExecuteScript("dpss_ambient_anim",OBJECT_SELF));
		}

	
	//Hydra's extra attacks
	if(GetTag(OBJECT_SELF) == "abr_cr_mb_hydra5") {
	SetBaseAttackBonus(5, OBJECT_SELF);
	int nBAB = GetBaseAttackBonus(OBJECT_SELF);
	SendMessageToAllDMs("Hydra base attacks at " + IntToString(nBAB));
	}
		
	

    // Custom code goes here.
		if ((!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "ACR_SPAWN_PARENT_WP")))  && (GetItemActivator()==OBJECT_INVALID))
		{//SendMessageToAllDMs("Setting Flocking to FALSE");
		// creature was not spawned by a waypoint, so likely was DM-created.  Disable flocking.
		SetLocalInt(OBJECT_SELF, "ACR_FLOCKING", FALSE);
		// no need to run any of the rest of this code
		return;
	}
	
			object oDM = GetItemActivator();
			int iRadius = 0;
			int iArea = 0;
			if(oDM != OBJECT_INVALID)
				{iRadius = GetLocalInt(oDM, "iRadiusFlocking");
				 iArea = GetLocalInt(oDM, "iAreaFlocking");
				 }
			object oFlocker = GetItemActivatedTarget();
				if(oFlocker == OBJECT_INVALID)
				{oFlocker = OBJECT_SELF;
				}		
			object oOwner = OBJECT_SELF;
			int iFlocking = GetLocalInt(oFlocker, "ACR_FLOCKING");
			if((iFlocking==0) && (GetIsDM(oOwner)))
				{SetLocalInt(oFlocker, "ACR_FLOCKING", 1);
				//SendMessageToAllDMs("iFlocking was 0 is 1");
				}
	
	
	if(GetLocalInt(oFlocker, "ACR_FLOCKING") == 1) 
					{object oMobDestination = GetNearestObject(OBJECT_TYPE_PLACEABLE, oFlocker, 1);
					 //SendMessageToAllDMs("oMobDestination = " + GetTag(oMobDestination) + "/" +GetName(oMobDestination));
					 string sArea = GetName(GetArea(oFlocker));
					 //Set the flocking destinations and execute the flocking script	
					 object oRandom1 = GetNearestObject(OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_CREATURE, oFlocker, Random(10));
					 //SendMessageToAllDMs("oRandom1a = " + GetTag(oRandom1) + "/" +GetName(oRandom1));
					 if((FindSubString(GetName(oRandom1), "Sky") != -1) || (FindSubString(GetName(oRandom1), "Walkmesh") != -1) || (FindSubString(GetName(oRandom1), "Boat") != -1))
							{oRandom1 = oMobDestination;
							//SendMessageToAllDMs("oRandom1b = " + GetTag(oRandom1) + "/" +GetName(oRandom1));
					         }
					 
					 if((GetObjectType(oRandom1) == OBJECT_TYPE_WAYPOINT) && (FindSubString(GetTag(oRandom1), "SPAWN") == -1))
								{oRandom1 = oMobDestination;}
								
					//SendMessageToAllDMs("oRandom1c = " + GetTag(oRandom1) + "/" +GetName(oRandom1));
					//if(oRandom1==OBJECT_INVALID)
						//{SendMessageToAllDMs("oRandom1=OBJECT_INVALID");} 				
					//SendMessageToAllDMs(GetTag(oFlocker) + " flocking");
					SetLocalInt(oFlocker, "ACR_FLOCKING", 1);
									 
					if(iRadius != 0)
							{object oChild = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, GetLocation(oFlocker), FALSE, OBJECT_TYPE_CREATURE); 
					    	 while(oChild != OBJECT_INVALID) 
								{if((GetIsPC(oChild) == FALSE) && (GetIsDM(oChild) == FALSE) && (GetLocalInt(oChild, "Flocked") != 1))
									{//SendMessageToAllDMs(GetTag(oChild) + " flocking");
									 SetLocalInt(oChild, "ACR_FLOCKING", 1);
							 		 DelayCommand(5.0, ExecuteScript("acf_cre_onspawnin", oChild));
									 }
								 oChild = GetNextObjectInShape(SHAPE_SPHERE, 25.0, GetLocation(oFlocker), FALSE, OBJECT_TYPE_CREATURE);
								}
								
								SetLocalInt(oDM, "iRadiusFlocking", 0);
							}
							
							if(iArea != 0)
								{object oChild = GetFirstObjectInArea(GetArea(oFlocker)); 
		 						 while(oChild != OBJECT_INVALID) 
									{if((GetIsPC(oChild) == FALSE) && (GetIsDM(oChild) == FALSE) && (GetLocalInt(oChild, "Flocked") != 1))
										{ SetLocalInt(oChild, "ACR_FLOCKING", 1);
					 		 			  DelayCommand(5.0, ExecuteScript("acf_cre_onspawnin", oChild));
										}
								 	oChild = GetNextObjectInArea(GetArea(oFlocker));
									}
								 SetLocalInt(oDM, "iAreaFlocking", 0);
								  }
							
							
							if((GetIsInCombat(oFlocker) == FALSE) && (!GetIsPC(oFlocker)) && (!GetIsDM(oFlocker)) && (GetLocalInt(oFlocker, "ACR_FLOCKING") == 1))
								{ClearAllActions(FALSE);
								 //SendMessageToAllDMs(GetTag(oFlocker) + " moving to " + GetTag(oRandom1)  + "/" + GetName(oRandom1));
								 AssignCommand(oFlocker, ActionMoveToObject(oRandom1, FALSE, 1.0f));
								 DelayCommand(IntToFloat(Random(60) + 60), ExecuteScript("acf_cre_onspawnin", oFlocker));
								 }
					}	 

}