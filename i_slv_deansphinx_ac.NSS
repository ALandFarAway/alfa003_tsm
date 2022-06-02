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
		{oBookshelf = GetObjectByTag("slv_vala_bookcase_sphinx");
		 SetLocalObject(OBJECT_SELF, "oBookshelf", oBookshelf);
		 }
 	effect eGlimmer = EffectVisualEffect(VFX_DUR_PIXIEDUST, FALSE);
    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1, FALSE);
    
	if((GetName(GetItemActivator()) == "Wynna") || (FindSubString(GetName(GetItemActivator()), "Wynna", 0) != -1))
        {SendMessageToAllDMs(GetName(GetItemActivator()) + " activated " + GetName(oItem));
		 SetLocalObject(GetModule(), "oWynna", GetItemActivator());}
        {}
    SetLocalObject(OBJECT_SELF, "oNPC", oNPC);

	
	
 
         
         if((GetDistanceBetween(oStudent, oBookshelf) < 10.0) && (oBookshelf != OBJECT_INVALID))
                {if(GetLocalInt(oStudent, "SphinxMsg") != 1)
		            {SendMessageToPC(oStudent, "Patterns shift deep in the crystal shard inset into the sphinx figurine. An instant later, a glow fades in around the metal sphinx bust protruding from the wall. Its mouth opens.");
		             SetLocalInt(oStudent, "SphinxMsg", 1);
		             }
             	 SetLocalInt(oStudent, "DeanSphinxConversation", 0);
                 SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
                 object oSphinx = GetObjectByTag("vala_sphinx");
				 object oSphinx_WP = GetWaypointByTag("Vala_Sphinx_WP");
				 object oVoice = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_deanvoice_sphinx", GetLocation(oSphinx_WP));
                 object oCabinetStatic = GetObjectByTag("vala_cabinet_static");
				 object oCabinet = GetObjectByTag("vala_cabinet");
				 object oCollBox = GetObjectByTag("vala_CollBox");
				 object oCabinetWP = GetWaypointByTag("Valamaradace_Cabinet_WP");
				 location lCabinet = GetLocation(oCabinetWP);
				 SetLocalObject(oVoice, "oStudent", oStudent);
                 SetLocalObject(oVoice, "oSphinx", oSphinx);
                 SetLocalObject(oVoice, "oCabinetStatic", oCabinetStatic);
                 SetLocalObject(oVoice, "oCabinet", oCabinet);
                 SetLocalObject(oVoice, "oCollBox", oCollBox);
                 SetLocalObject(oCabinet, "oStatic", oCabinetStatic);
                 SetLocalObject(oCabinet, "oCollBox", oCollBox);
                 SetLocalLocation(oVoice, "lCabinet", lCabinet);
                 SetLocalObject(oSphinx, "oStudent", oStudent);
                 SetLocalObject(oSphinx, "oVoice", oVoice);
                 DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlimmer, oSphinx, 10.0));
                 DelayCommand(4.0, ExecuteScript("slv_static_voice_sphinx", oVoice));
                 DestroyObject(oVoice, 600.5);
                 }
              
          {}
		  
}