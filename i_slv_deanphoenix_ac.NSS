#include "silvy_univ_inc"
#include "acr_spawn_i"
#include "acr_db_persist_i"
#include "silvy_univ_func"
void main()
{
             
//OnActivate Script for the 'key' to the static quest giving bookshelf. 
	object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    object oStudent = oUser;
	object oNPC = GetItemActivatedTarget();
    object oBookshelf = GetLocalObject(OBJECT_SELF, "oBookshelf");
	if(oBookshelf == OBJECT_INVALID)
		{oBookshelf = GetObjectByTag("slv_vala_bookcase_phoenix");
		 SetLocalObject(OBJECT_SELF, "oBookshelf", oBookshelf);
		 }
 	effect eGlimmer = EffectVisualEffect(VFX_DUR_PIXIEDUST, FALSE);
    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1, FALSE);
    
	if((GetName(GetItemActivator()) == "Wynna") || (FindSubString(GetName(GetItemActivator()), "Wynna", 0) != -1))
        {SendMessageToAllDMs(GetName(GetItemActivator()) + " activated Carved Phoenix");
		 SetLocalObject(GetModule(), "oWynna", GetItemActivator());}
        {}
    SetLocalObject(OBJECT_SELF, "oNPC", oNPC);

	
	
 
         
         if((GetDistanceBetween(oStudent, oBookshelf) < 10.0) && (oBookshelf != OBJECT_INVALID))
                {if(GetLocalInt(oStudent, "PhoenixMsg") != 1)
		            {SendMessageToPC(oStudent, "Fire seems to stir deep in the facets of the reddish quartz in your hand. An instant later, the painted metal phoenix bust protruding from the wall shimmers. The beak clatters open.");
		             SetLocalInt(oStudent, "PhoenixMsg", 1);
		             }
             	 SetLocalInt(oStudent, "DeanPhoenixConversation", 0);
                 SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
                 object oPhoenix = GetObjectByTag("vala_phoenix");
				 object oPhoenix_WP = GetWaypointByTag("Vala_Phoenix_WP");
				 object oVoice = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_deanvoice_phoenix", GetLocation(oPhoenix_WP));
                 object oCabinetStatic = GetObjectByTag("vala_cabinet_static");
				 object oCabinet = GetObjectByTag("vala_cabinet");
				 object oCollBox = GetObjectByTag("vala_CollBox");
				 object oCabinetWP = GetWaypointByTag("Valamaradace_Cabinet_WP");
				 location lCabinet = GetLocation(oCabinetWP);
				 SetLocalObject(oVoice, "oStudent", oStudent);
                 SetLocalObject(oVoice, "oPhoenix", oPhoenix);
                 SetLocalObject(oVoice, "oCabinetStatic", oCabinetStatic);
                 SetLocalObject(oVoice, "oCabinet", oCabinet);
                 SetLocalObject(oVoice, "oCollBox", oCollBox);
                 SetLocalObject(oCabinet, "oStatic", oCabinetStatic);
                 SetLocalObject(oCabinet, "oCollBox", oCollBox);
                 SetLocalLocation(oVoice, "lCabinet", lCabinet);
                 SetLocalObject(oPhoenix, "oStudent", oStudent);
                 SetLocalObject(oPhoenix, "oVoice", oVoice);
                 DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlimmer, oPhoenix, 10.0));
                 DelayCommand(4.0, ExecuteScript("slv_static_voice_phoenix", oVoice));
                 DestroyObject(oVoice, 600.5);
                 }
              
          {}
		  
}