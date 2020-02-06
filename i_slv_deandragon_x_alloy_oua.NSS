//Wynna February 2008


#include "acr_items_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_db_persist_i"


void main()
{	
	object oStudent = GetModuleItemLostBy();
    object oMod = GetModule();
	object oReceiver = GetModuleItemAcquiredBy();
	object oItem = GetModuleItemLost();
	object oXorn=GetObjectByTag("slv_deandragon_x_elderxorn");
	
	location lReceiver = GetLocation(oReceiver);
	vector vReceiver = GetPositionFromLocation(lReceiver);
	vector vGem = Vector(vReceiver.x, vReceiver.y, vReceiver.z + 3.0);
	location lGem = Location(GetArea(oReceiver), vGem, 0.0); 
	
	if((GetDistanceBetween(oStudent, oXorn) > 0.0) && (GetDistanceBetween(oStudent, oXorn) < 30.0) && (ACR_RetrieveQuestState("slv_deandragon_x", oStudent) == 5))
		{AssignCommand(oXorn, ActionSpeakString("*Digs itself out of sight, through the floor leaving only a pile of excreted rubble.", TALKVOLUME_TALK));
		effect eDust = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION, FALSE);
		effect eStone = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM, FALSE);
		DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oXorn)));
		DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oXorn)));
		DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oXorn)));
		DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oXorn)));
		DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oXorn)));
		DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oXorn)));
	
		DestroyObject(oXorn, 3.0);
		DestroyObject(oItem, 5.0);
		 		 
		location lUser = GetLocation(oStudent);
		object oDisgorged = GetLocalObject(OBJECT_SELF, "oDisgorged");
		if(oDisgorged == OBJECT_INVALID)
			 {oDisgorged = GetWaypointByTag("xorn_disgorge_nether_slopes");
			  SetLocalObject(OBJECT_SELF, "oDisgorged", oDisgorged);
			 }
			 
		//SendMessageToPC(oStudent, GetTag(oDisgorged));
			
		if((ACR_RetrieveQuestState("slv_deandragon_x", oStudent) == 4) || (ACR_RetrieveQuestState("slv_deandragon_x", oStudent) == 5)) 
		 	{DelayCommand(30.0, ACR_AddPersistentJournalQuestEntry("slv_deandragon_x", 5, oStudent, FALSE, FALSE, FALSE, FALSE));
			 }
			 object oPartyMember = GetFirstObjectInShape(SHAPE_SPHERE, 60.0, GetLocation(oStudent), FALSE, OBJECT_TYPE_CREATURE);
		     while(oPartyMember!=OBJECT_INVALID)
				 {if(GetIsPC(oPartyMember)) 
					{
					 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oPartyMember));
					 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oPartyMember));
					 object oXornEaten = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_xorn_body", GetLocation(oDisgorged));
				 	 //object oXornEater = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_xorn_body", GetLocation(oStudent));
				 	// DelayCommand(1.0, AssignCommand(oXornEater, ActionSpeakString("*Erupts from the ground and engulfs the party whole! All limbs and eyes have merged with the body to create a smooth, frictionless surface.", TALKVOLUME_TALK)));
				     //DestroyObject(oXornEater, 30.0);
					 DestroyObject(oXornEaten, 35.0);
					 DelayCommand(7.0, SendMessageToPC(oPartyMember, "You have been swallowed by a Xorn! Rock presses you from all sides. You can hardly breath, and just barely expand your ribcage. It is exactly like being buried alive."));
					 DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oPartyMember)));
					 DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oPartyMember)));
					 DelayCommand(12.0, AssignCommand(oPartyMember, ActionJumpToLocation(GetLocation(oDisgorged))));
					 DelayCommand(30.0, SendMessageToPC(oPartyMember, "*Disgorges you in a cloud of dust and clods of dirt. It drops away from around you and is gone through the icy stone of this place...which does not look like civilized Silverymoon!"));
					 DelayCommand(35.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oDisgorged)));
					 DelayCommand(35.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oDisgorged)));
					 DelayCommand(40.0, SendMessageToPC(oStudent, "You travelled for what seemed an eternity and might have been half an hour, but have no idea how far you have come. All you are certain of is that something went wrong in the destination, if the xorn was meant to take you to Silverymoon."));
				     oPartyMember = GetNextObjectInShape(SHAPE_SPHERE, 60.0, GetLocation(oStudent), FALSE, OBJECT_TYPE_CREATURE);
				    }
				}
				 
				 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oStudent));
				 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oStudent));
				 object oXornEaten2 = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_xorn_body", GetLocation(oDisgorged));
				 //object oXornEater2 = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_xorn_body", GetLocation(oStudent));
				 //DelayCommand(1.0, AssignCommand(oXornEater2, ActionSpeakString("*Erupts from the ground and engulfs the party whole! All limbs and eyes have merged with the body to create a smooth, frictionless surface.", TALKVOLUME_TALK)));
				 //DelayCommand(7.0, SendMessageToPC(oStudent, "2.You have been swallowed by a Xorn! Rock presses you from all sides. You cannot breath, nor even expand your ribcage. It is exactly like being buried alive."));
				 DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oStudent)));
				 DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oStudent)));
				 DelayCommand(10.0, AssignCommand(oXorn, ActionJumpToLocation(GetLocation(oDisgorged))));
				 DelayCommand(12.0, AssignCommand(oStudent, ActionJumpToLocation(GetLocation(oDisgorged))));
				 //DelayCommand(30.0, AssignCommand(oXornEaten2, ActionSpeakString("*2.Disgorges its passenger in a cloud of dust and clods of dirt. It drops away from around you and is gone through the icy stone of this place...which does not look like civilized Silverymoon!", TALKVOLUME_TALK)));
				 //DestroyObject(oXornEater2, 30.0);
				 DestroyObject(oXornEaten2, 35.0);
				 DelayCommand(30.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oDisgorged)));
				 DelayCommand(30.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oDisgorged)));
				 //DelayCommand(40.0, SendMessageToPC(oStudent, "2.You travelled for what seemed an eternity and might have been half an hour, but have no idea how far you have come. All you are certain of is that something went wrong in the destination, if the xorn was meant to take you to Silverymoon."));
				 
				}
			 
	}