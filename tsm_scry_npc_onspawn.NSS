#include "acr_spawn_i"
#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "acr_quest_i"
 
void main()
{
	AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF));
	effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
	effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
	effect eEthereal = EffectEthereal();
	SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 50, OBJECT_SELF);
	effect eGhost = EffectCutsceneGhost();	 	 		     	      
         
		if(GetTag(OBJECT_SELF)== "003_cr_scry_namer") {
			 //Initialize Invisible Listener that will facilitate setting a Roster Name for an NPC scrying target
			 //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, OBJECT_SELF);
			 //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
			 //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);
			 //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEthereal, OBJECT_SELF);
			 
			 SetListenPattern(OBJECT_SELF, "**", 6031);
			 SetListening(OBJECT_SELF, TRUE);
			 
		}
	
		if((GetTag(OBJECT_SELF)== "003_cr_scry_send") || (GetTag(OBJECT_SELF)== "003_cr_scry_send_xavier")) {
			 //Initialize Invisible Scrying Sensor that relays words spoken by or to the scrying target
			 //Detect Scrying or See Invisibility will reveal it IC
			 //Silverymoon's mythal reveals all scrying sensors
			 SetListenPattern(OBJECT_SELF, "**", 6031);
			 SetListening(OBJECT_SELF, TRUE);
			 object oScried = GetLocalObject(OBJECT_SELF, "oScried");
			 ActionForceFollowObject(oScried, 0.5f, 0);
			 if((FindSubString(GetTag(GetArea(OBJECT_SELF)), "6d_int_silvy") == -1)  && (!GetLocalInt(GetArea(OBJECT_SELF), "IS_SILVERYMOON_EXT")))
				{ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);
				 SendMessageToPC(oScried, "You abruptly know that you are being scried.");
				}
    	     
			 
			 object oDetector = GetFirstObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
			 while (oDetector != OBJECT_INVALID) {
				if(GetLocalInt(oDetector, "nDetectScrying") == 1) {
					SendMessageToPC(oDetector, "You see a small glowing orb appear in the air above " + GetName(oScried));
					
					 object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
					 string sScryerDesc = GetDescription(oScryer);
					 object oScryerArea = GetArea(oScryer);
					 string sScryerArea = GetName(oScryerArea);
					 int nCasterLevel = GetLocalInt(OBJECT_SELF, "nCasterLevel");
					 int nCasterRoll = d20(1);
					 int nCasterOpposed = nCasterLevel + nCasterRoll;
					 int nDetectorLevel = GetCasterLevel(oDetector);
					 int nDetectorRoll = d20(1);
					 int nDetectorOpposed = nDetectorLevel + nDetectorRoll;
					 if(nDetectorOpposed >= nCasterOpposed) {
					  	SendMessageToPC(oDetector, "You feel your Detect Scrying spell best the defences of the person scrying you.");
						SendMessageToPC(oDetector, "You get a visual image of the scryer: " + sScryerDesc);
						SendMessageToPC(oDetector, "You know that this person is located at the direction and distance of " + sScryerArea );
						}
					 else {SendMessageToPC(oDetector, "You feel your Detect Scrying spell try and fail to identify the person scrying you.");}
		 	
					
					effect eEffect = GetFirstEffect(OBJECT_SELF);
					int nRep = 0;
					while ((GetIsEffectValid(eEffect)) && (nRep < 10)) { 
						RemoveEffect(OBJECT_SELF, eEffect);
						eEffect = GetNextEffect(OBJECT_SELF);
						nRep ++;
						}
					}
				oDetector = GetNextObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
			}
		}
		
		if(GetTag(OBJECT_SELF)== "003_cr_scry_listen") {
			 //Initialize OOC undetectable Scrying Listener that receives information from the Scrying Sensor	 
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, OBJECT_SELF);
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEthereal, OBJECT_SELF);
			 
			 //Get Local Objects set by Spellhook at time of casting Scrying spell
			 object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
		     object oScry = GetLocalObject(OBJECT_SELF, "oScry");
			 string sScryName = GetName(oScry);
			 
			 //Tell ScryListen what words it is listening for to determine adjustments to Scryer's DC carried out later by tsm_scry_npc_convo
			 SetListenPattern(OBJECT_SELF, "**None**", 6010);
			 SetListenPattern(OBJECT_SELF, "**Firsthand**", 6011);
			 SetListenPattern(OBJECT_SELF, "**Secondhand**", 6012);
			 SetListenPattern(OBJECT_SELF, "**Familiar**", 6013);
			 SetListenPattern(OBJECT_SELF, "**Nothing**", 6014);
			 SetListenPattern(OBJECT_SELF, "**Picture**", 6015);
			 SetListenPattern(OBJECT_SELF, "**Possession**", 6016);
			 SetListenPattern(OBJECT_SELF, "**Body**", 6017);
			 
			 //Tell ScryListen the names of ten PCs logged in at the time it spawns	 
			 int nListenPattern = 6020;
         	 object oPC = GetFirstPC(FALSE);
			 while ((oPC != OBJECT_INVALID) && (nListenPattern < 6030)) {
				 string sPCName = GetName(oPC);
				 //SendMessageToPC(oScryer, "Listener Spawn : sPCName = " + sPCName  + " : " + IntToString(nListenPattern));
				 SetListenPattern(OBJECT_SELF, "**" + sPCName + "**", nListenPattern);
				 nListenPattern++;
				 oPC = GetNextPC(FALSE);
			 }
			 
			 nListenPattern = 6030;
			 string sRoster = GetFirstRosterMember();
			 while ((sRoster != "") && (nListenPattern < 6040)) {
				 //SendMessageToPC(oScryer, "Listener Spawn: "  + " sRoster = " + sRoster + " : " + IntToString(nListenPattern));
				 SetListenPattern(OBJECT_SELF, "**" + sRoster + "**", nListenPattern);
				 nListenPattern++;
				 sRoster = GetNextRosterMember();
			 }
			  
			 //Tell ScryListen to Listen	 
			 SetListening(OBJECT_SELF, TRUE);
			 
			 //Begin interaction with Scryer
			 string sSpeak = GetLocalString(oScry, "SCRY_SPEAK");
			 ActionSpeakString(sSpeak, TALKVOLUME_TALK);
			 effect eDivination = EffectVisualEffect(VFX_HIT_SPELL_DIVINATION, FALSE);
			 ApplyEffectToObject(DURATION_TYPE_INSTANT, eDivination, oScry);
			 DelayCommand(2.0, SendMessageToPC(oScryer, "Inform the " + sScryName + " whether your knowledge of the person you intend to scry is 'None', 'Firsthand', 'Secondhand', or 'Familiar'."));
		 	 DelayCommand(4.0, SendMessageToPC(oScryer, "In a separate statement, inform the " + sScryName + " whether you have a 'Picture', 'Possession', 'Body Part', or 'Nothing' of the scrying subject."));
			 DelayCommand(6.0, SendMessageToPC(oScryer, "In a third statement, speak the full name of the person to be scried."));
			
			 //Unset all currently existing local variables before self destruction at the end of the potential Scry spell as a backup in case the Scry spell itself fails
			 float fScryTimer = GetLocalFloat(OBJECT_SELF, "fScryTimer");	
			 DelayCommand(fScryTimer + 15.0, SetLocalFloat(OBJECT_SELF, "fScryTimer", 0.0));
			 DelayCommand(fScryTimer + 15.0, SetLocalObject(oScry, "oScryListen", OBJECT_INVALID));
			 DelayCommand(fScryTimer + 15.0, SetLocalObject(oScry, "oScryer", OBJECT_INVALID));
			 DelayCommand(fScryTimer + 15.0, SetLocalObject(oScryer, "oScryListen", OBJECT_INVALID));
			 DelayCommand(fScryTimer + 15.0, SetLocalObject(oScryer, "oScry", OBJECT_INVALID));
			 DelayCommand(fScryTimer + 15.0, SetLocalObject(OBJECT_SELF, "oScry", OBJECT_INVALID));
			 DelayCommand(fScryTimer + 15.0, SetLocalObject(OBJECT_SELF, "oScryer", OBJECT_INVALID));
			 DestroyObject(OBJECT_SELF, fScryTimer + 15.0);
			 
			 //Over to conversation script: tsm_scry_npc_onconvo
			 
		}  
   }