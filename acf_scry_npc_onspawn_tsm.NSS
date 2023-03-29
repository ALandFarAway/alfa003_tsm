//
//  System Name : Scrying
//     Filename : acf_scry_npc_onspawn
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script sets spawn variables on NPCs used in the scrying system. 
//  This should be in the On Spawn In Script slot of these creatures: 
//	Invisible Scrying Speaker - Spawned by Scry or Greater Scry spell. Initializes scrying receiver at location of oScryer
//	Invisible Scrying Namer - Spawned by activating a scrying focus on a scrying object. Listens for any pattern at location of scrying object
//	Invisible Scrying Sender -  Spawned on the target of a successful scrying spell. Initializes scrying sensor at location of oScried, checks for Detect effects
//	Invisible Scryer's Presence - Spawned on the scryer of a successful scrying spell. Listens for any pattern at location of scrying object and gets oScried
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_spawn_i"
#include "acr_scry_i"

void main()
{
	AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF));
	effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
	effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
	effect eEthereal = EffectEthereal();
	effect eGhost = EffectCutsceneGhost();	 	 		     	      
    SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 50, OBJECT_SELF);
	  
 		if(GetTag(OBJECT_SELF)== "003_cr_scry_speak") {
			 //Initialize OOC undetectable Scrying Listener that receives information from the Scrying Sensor	 
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, OBJECT_SELF);
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEthereal, OBJECT_SELF);
			 
			 //Get Local Objects set at time of casting Scrying spell
			 object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
		     object oScry = GetLocalObject(OBJECT_SELF, "oScry");
			 string sScryName = GetName(oScry);
			 
			 //Tell ScryListen the names of ten PCs logged in at the time it spawns	 
			 int nListenPattern = 6020;
         	 object oPC = GetFirstPC(FALSE);
			 while ((oPC != OBJECT_INVALID) && (nListenPattern < 6030)) {
				 string sPCName = GetName(oPC);
				 SetListenPattern(OBJECT_SELF, "**" + sPCName + "**", nListenPattern);
				 nListenPattern++;
				 oPC = GetNextPC(FALSE);
			 }
			 
			 string sScryTargetA = GetLocalString(oScry, "sScryTargetA");
			 string sScryTargetB = GetLocalString(oScry, "sScryTargetB");
			 string sScryTargetC = GetLocalString(oScry, "sScryTargetC");
			 string sScryTargetD = GetLocalString(oScry, "sScryTargetD");
			 string sScryTargetE = GetLocalString(oScry, "sScryTargetE");
			 string sScryTargetF = GetLocalString(oScry, "sScryTargetF");
			 string sScryTargetG = GetLocalString(oScry, "sScryTargetG");
			 string sScryTargetH = GetLocalString(oScry, "sScryTargetH");
			 string sScryTargetI = GetLocalString(oScry, "sScryTargetI");
			 string sScryTargetJ = GetLocalString(oScry, "sScryTargetJ");
			 
			 if(sScryTargetA != "") {
				 SetListenPattern(OBJECT_SELF, "**" + sScryTargetA + "**", 6030);
				 }
			 if(sScryTargetB != "") {
				 SetListenPattern(OBJECT_SELF, "**" + sScryTargetB + "**", 6031);
				 }
			 if(sScryTargetC != "") {
				 SetListenPattern(OBJECT_SELF, "**" + sScryTargetC + "**", 6032);
				 }
			 if(sScryTargetD != "") {
				 SetListenPattern(OBJECT_SELF, "**" + sScryTargetD + "**", 6033);
				 }
			 if(sScryTargetE != "") {
				 SetListenPattern(OBJECT_SELF, "**" + sScryTargetE + "**", 6034);
				 }
			 if(sScryTargetF != "") {
				 SetListenPattern(OBJECT_SELF, "**" + sScryTargetF + "**", 6035);
				 }
			 if(sScryTargetG != "") {
				 SetListenPattern(OBJECT_SELF, "**" + sScryTargetG + "**", 6036);
				 }
			 if(sScryTargetH != "") {
				 SetListenPattern(OBJECT_SELF, "**" + sScryTargetH + "**", 6037);
				 }
			 if(sScryTargetI != "") {
				 SetListenPattern(OBJECT_SELF, "**" + sScryTargetI + "**", 6038);
				 }
			 if(sScryTargetJ != "") {
				 SetListenPattern(OBJECT_SELF, "**" + sScryTargetJ + "**", 6039);
				 }
			 
			 SetListenPattern(OBJECT_SELF, "**End Scry**", 6040);
			 SetListenPattern(OBJECT_SELF, "**", 6041);
			  
			 //Tell ScryListen to Listen	 
			 SetListening(OBJECT_SELF, TRUE);
			 
			 //Begin interaction with Scryer
			 string sSpeak = GetLocalString(oScry, "SCRY_SPEAK");
			 ActionSpeakString(sSpeak, TALKVOLUME_TALK);
			 effect eDivination = EffectVisualEffect(VFX_HIT_SPELL_DIVINATION, FALSE);
			 ApplyEffectToObject(DURATION_TYPE_INSTANT, eDivination, oScry);
			 SendMessageToPC(oScryer, "Speak the name or nickname of a subject you wish to attempt to scry. This " + GetName(oScry) + " must have been keyed recently by a scrying focus imbued with their identity.");
			 SendMessageToPC(oScryer, "Holding an imbued scrying shard or droplet will improve *both* the connection to *and* knowledge of any target. Holding a possession or body part will improve the connection to any target.");
			
			 //Unset all currently existing local variables before self destruction at the end of the potential Scry spell as a backup in case the Scry spell itself fails
			 float fScryTimer = GetLocalFloat(OBJECT_SELF, "fScryTimer");	
			 DelayCommand(fScryTimer + 15.0, SetLocalFloat(OBJECT_SELF, "fScryTimer", 0.0));
			 DelayCommand(fScryTimer + 15.0, SetLocalObject(oScry, "oScrySpeak", OBJECT_INVALID));
			 DelayCommand(fScryTimer + 15.0, SetLocalObject(oScry, "oScryer", OBJECT_INVALID));
			 DelayCommand(fScryTimer + 15.0, SetLocalObject(oScryer, "oScrySpeak", OBJECT_INVALID));
			 DelayCommand(fScryTimer + 15.0, SetLocalObject(oScryer, "oScry", OBJECT_INVALID));
			 DelayCommand(fScryTimer + 15.0, SetLocalObject(OBJECT_SELF, "oScry", OBJECT_INVALID));
			 DelayCommand(fScryTimer + 15.0, SetLocalObject(OBJECT_SELF, "oScryer", OBJECT_INVALID));
			 DestroyObject(OBJECT_SELF, fScryTimer + 15.0);
			 
			 //Over to conversation script: acf_scry_npc_onconvo
			 
		}  
		
		if(GetTag(OBJECT_SELF)== "003_cr_scry_namer") {
			 //Initialize Invisible Listener that will facilitate setting a Roster Name for an NPC scrying target
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, OBJECT_SELF);
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEthereal, OBJECT_SELF);
			 
			 SetListenPattern(OBJECT_SELF, "**", 6041);
			 SetListening(OBJECT_SELF, TRUE);
		}
	
		if((GetTag(OBJECT_SELF)== "003_cr_scry_send") || (GetTag(OBJECT_SELF)== "003_cr_scry_send_xavier")) {
			 //Initialize Invisible Scrying Sensor that relays words spoken by or to the scrying target
			 //Detect Scrying or See Invisibility will reveal it IC
			 //Silverymoon's mythal reveals all scrying sensors
			 SetListenPattern(OBJECT_SELF, "**End Scry**", 6040);
			 SetListenPattern(OBJECT_SELF, "**", 6041);
			 SetListening(OBJECT_SELF, TRUE);
			 object oScried = GetLocalObject(OBJECT_SELF, "oScried");
			 ActionForceFollowObject(oScried, 0.5f, 0);
			 if((FindSubString(GetTag(GetArea(OBJECT_SELF)), "6d_int_silvy") == -1)  && (FindSubString(GetTag(GetArea(OBJECT_SELF)), "6d_ext_silv") == -1))
				{ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);}
			 else {SendMessageToPC(oScried, "You abruptly know that you are being scried.");}
			
			 object oDetector = GetFirstObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
			 while (oDetector != OBJECT_INVALID) {
				if(GetLocalInt(oDetector, "abr_sp_detectScry") == 1) {
					SendMessageToPC(oDetector, "You see a small glowing orb appear in the air above " + GetName(oScried));
					
					 object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
					 object oScry = GetLocalObject(oScryer, "oScry");
		 			 object oScrySpeak = GetLocalObject(OBJECT_SELF, "oScrySpeak");
					 string sScryerDesc = GetDescription(oScryer);
					 object oScryerArea = GetArea(oScryer);
					 string sScryerArea = GetName(oScryerArea);
					 int nCasterLevel = GetLocalInt(OBJECT_SELF, "nCasterLevel");
					 int nCasterRoll = d20(1);
					 int nCasterOpposed = nCasterLevel + nCasterRoll;
					 int nDetectorLevel = GetCasterLevel(oDetector);
					 int nDetectorRoll = d20(1);
					 int nDetectorOpposed = nDetectorLevel + nDetectorRoll;
					 if((nDetectorOpposed >= nCasterOpposed) && (GetLocalString(OBJECT_SELF, "ID_Failed")!= GetName(oDetector))) {
					  	SendMessageToPC(oDetector, "You feel your Detect Scrying spell best the defences of the person scrying you.");
						SendMessageToPC(oDetector, "You get a visual image of the scryer: " + GetName(oScryer));
						SendMessageToPC(oDetector, "You know that this person is located at the direction and distance of " + sScryerArea );
						SendMessageToPC(oDetector, "A moment later, the scrying sensor vanishes.");
						}
					 else {SendMessageToPC(oDetector, "You feel your Detect Scrying spell try and fail to identify the person scrying you.");
					 	SetLocalString(OBJECT_SELF, "ID_Failed", GetName(oDetector));
					 }
		 	
					
					effect eEffect = GetFirstEffect(OBJECT_SELF);
					int nRep = 0;
					while ((GetIsEffectValid(eEffect)) && (nRep < 10)) { 
						RemoveEffect(OBJECT_SELF, eEffect);
						eEffect = GetNextEffect(OBJECT_SELF);
						nRep ++;
						}
					SetLocalObject(oScry, "oScried", OBJECT_INVALID);
					SetLocalObject(oScry, "oScrySpeak", OBJECT_INVALID);
					SetLocalObject(oScry, "oScryer", OBJECT_INVALID);
					SetLocalObject(oScry, "oScrySend", OBJECT_INVALID);
					SetLocalObject(oScryer, "oScried", OBJECT_INVALID);
					SetLocalObject(oScryer, "oScrySpeak", OBJECT_INVALID);
					SetLocalObject(oScryer, "oScrySend", OBJECT_INVALID);
					SetLocalObject(oScryer, "oScry", OBJECT_INVALID);
					SetLocalObject(oScried, "oScrySpeak", OBJECT_INVALID);
					SetLocalObject(oScried, "oScryer", OBJECT_INVALID);
					SetLocalObject(oScried, "oScry", OBJECT_INVALID);
					SetLocalObject(oScried, "oScrySend", OBJECT_INVALID);
					SetLocalInt(oScry, "nScryActive", 0);
					DestroyObject(oScrySpeak, 2.0);		
					DestroyObject(OBJECT_SELF, 6.0);
					}
				oDetector = GetNextObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
				}
				
		}
		
		if(GetTag(OBJECT_SELF)== "003_cr_scry_self") {
			 //Initialize duplicate oScryer at scrying object that will feed local conversation to PC Scryer while PC Scryer is with oScried
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, OBJECT_SELF);
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);
			 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEthereal, OBJECT_SELF);
			 
			 SetListenPattern(OBJECT_SELF, "**", 6031);
			 SetListening(OBJECT_SELF, TRUE);
			 object oScried = GetLocalObject(OBJECT_SELF, "oScried");
			 object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
			 SendMessageToPC(oScryer, "Distantly, you are aware of activity or voices where you stood when you cast Scrying, but for now your focus through the sensor is so clear it feels as if you are there with " + GetName(oScried) + "." );
			 }
  }