//Torches, braziers, woodpiles, candles with this in the OnSpellCastAt slot will create a lit version of themselves when appropriate spells are cast at it 
//Lit version will self-destroy in 30 minutes.
//Wynna February 2008


#include "acr_placeable_i"
#include "acr_db_persist_i"
#include "acr_tools_i"
#include "acr_quest_i"

void main()
{
	ACR_PlaceableOnSpellCastAt();
    object oPC = GetLastSpellCaster();
    string sTagLit = GetTag(OBJECT_SELF) + "_lit";
	int nSpell=GetLastSpell();
		
	 if((nSpell==19) || (nSpell==39) || (nSpell==57) || (nSpell==58) || (nSpell==59) || (nSpell==61) || (nSpell==191) || (nSpell==219) || (nSpell==57) || (nSpell==232) || (nSpell==239) || (nSpell==264) || (nSpell==284) || (nSpell==416) || (nSpell==425) || (nSpell==440) || (nSpell==518)  || (nSpell==665) || (nSpell==690) || (nSpell==797) || (nSpell==851) || (nSpell==869 || (nSpell==871)))
		{object oLit = CreateObject(OBJECT_TYPE_PLACEABLE, sTagLit, GetLocation(OBJECT_SELF));
		 DestroyObject(oLit, 1800.0);
		 }
}