// Set this on the onenter of the trigger 
// set   message= " what you want the message to be " in the variable


void main()
{    
    object oPC = GetEnteringObject();
    object oTrigger = OBJECT_SELF;
    
    string sMessage = GetLocalString(oTrigger, "message");
    SendMessageToPC(oPC, sMessage);
}

//void ShowMessage(object oTarget, string sMessage)
//{
//    SendMessageToPC(oTarget, sMessage);
//    FloatingTextStringOnCreature(sMessage, oTarget, FALSE);
//}