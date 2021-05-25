// THIS SCRIPT IS NOT A PART OF ACR
// set persistent int shell
#include "acr_db_persist_i"


void main(string plot, int val)
{
    object oPC = GetPCSpeaker();
	string name = plot;

	ACR_SetPersistentInt(oPC, name, val);
}