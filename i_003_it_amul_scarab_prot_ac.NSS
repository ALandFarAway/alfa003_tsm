#include "silvy_univ_inc"
#include "silvy_univ_func"

  //Created by Wynna; April 12, 2023


void main()
{
    object oItem = GetItemActivated();
   	object oUser = GetLastUsedBy();
	object oDoorNoble = GetObjectByTag("5f_ext_dt_tombs_nobles", 0);
	object oDoorMidrIn = GetObjectByTag("5f_ext_mdr_cave_in", 0);
	object oDoorMidrOut = GetObjectByTag("5f_int_mdr_cave_out", 0);
	
	 SendMessageToPC(oUser, "Nothing happens.");
	
 
}