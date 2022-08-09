#include "acr_quest_i"

// written by Saaz

const string QUEST_TOKEN_VAR = "sQuestToken";
const string QUEST_TAG_VAR = "sQuestTag";
const string QUEST_PLACEABLE_VAR = "sQuestPlc";
const string QUEST_DO_ONCE_VAR = "DoOnce";

void main()//
 {//
    object oPC = GetEnteringObject();//
	object oTarget;//
	int n;//
	string sQuestToken = GetLocalString(OBJECT_SELF,QUEST_TOKEN_VAR);
	if ((GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC)) && !GetLocalInt(OBJECT_SELF, QUEST_DO_ONCE_VAR))//
	if (!GetIsPC(oPC)) return;
{
    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRY" + sQuestToken) == 1)
	 {//
int n = 0;//
string sTargetTag = GetLocalString(OBJECT_SELF,QUEST_TAG_VAR);
string sPlaceableRef = GetLocalString(OBJECT_SELF,QUEST_PLACEABLE_VAR);
object oTarget = GetObjectByTag(sTargetTag);//
while (GetIsObjectValid(oTarget))//
    {//
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceableRef, GetLocation(oTarget));//
    n++;//
    oTarget = GetObjectByTag(sTargetTag, n);//
	SetLocalInt(OBJECT_SELF, QUEST_DO_ONCE_VAR, TRUE); //
	}
	 }//
 }
}//