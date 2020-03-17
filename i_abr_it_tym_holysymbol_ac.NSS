// i_abr_it_tym_holysymbol_ac

//:://////////////////////////////////////////////
//     Written by 4760 from NWvault
/*

    Simulate a heads or tails result
	For an NPC, you’ll probably want a ga_tosscoin script 
	(the NPC will start a conversation, and then tell the result).

*/

//:://////////////////////////////////////////////



void main()

{

	object oPC = GetItemActivator();

	string sResult = "heads";

	if (d2() == 1) sResult = "tails";

	//SendMessageToPC(oPC, "Lady Luck Shows you " + sResult);
    //ActionSpeakString( "Lady Luck Shows you " + sResult,2);
		AssignCommand(oPC, ActionSpeakString( "You flip a coin and Lady Luck Shows you " + sResult));
}