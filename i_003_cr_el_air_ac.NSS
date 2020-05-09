#include "silvy_univ_inc"
#include "silvy_univ_func"
#include "acr_quest_i"

  //Created by Wynna; May 9, 2020


void main()
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
    
	SendMessageToAllDMs("Activate Item script fired. " + GetName(oTarget) + "targeted by " + GetName(oUser));
	ActionSpeakString("Activate Item script fired. I targeted " + GetName(oTarget));
	DelayCommand(1.0, AssignCommand(oUser, ActionSpeakString("Activate Item script fired. Assigned Command: I targeted " + GetName(oTarget))));

	
	}