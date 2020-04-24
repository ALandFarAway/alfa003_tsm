// Argent Legion Supply Quest to Rivermoot
#include "acr_db_persist_i"
int StartingConditional()
{   
 if(GetItemPossessedBy(GetPCSpeaker(), "militarysupplieswe") == OBJECT_INVALID)
    return FALSE;
 if(ACR_GetPersistentInt(GetPCSpeaker(), "alsupply") != 1)
    return FALSE;	
 return TRUE;	   
}