#include "silvy_univ_inc"
#include "silvy_univ_func"

  //Created by Wynna; April 12, 2023


void main()
{
    object oItem = GetItemActivated();
   	object oUser = GetLastUsedBy();
	
	 SendMessageToPC(oUser, "Nothing happens.");
	
 
}