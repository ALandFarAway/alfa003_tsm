// Give supplies for the supply run quest for Quaervar
#include "acr_db_persist_i"

void main()
{
   CreateItemOnObject("militarysuppliesrm", GetPCSpeaker(), 1);
   ACR_SetPersistentInt(GetPCSpeaker(), "alsupply", 1);
}