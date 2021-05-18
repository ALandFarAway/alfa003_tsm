//Regrow hydra's damaged heads
//Wynna May 2021


#include "acr_creature_i"
#include "nw_i0_generic"


void main()
{
	ACR_CreatureOnDamaged();
	
	int nHeads = GetHitDice(OBJECT_SELF);
	int nCurrentHeads = GetLocalInt(OBJECT_SELF, "CurrentHeads");
	if(nCurrentHeads = 0)
		{nCurrentHeads = nHeads;}
	
	string sSRegrown = "s";
	int nRegrow = 2;
	if((nHeads*2)-nCurrentHeads < 2) {
		nRegrow = (nHeads*2)-nCurrentHeads < 2;
		}
	if(nRegrow < 2) {
		sSRegrown = "";
		}
	
	if((GetLocalInt(OBJECT_SELF, "Cauterized") == 1)&& (GetLocalInt(OBJECT_SELF, "Regrowing") == 1)) {
		ActionSpeakString("Damaged heads do not regrow!", TALKVOLUME_TALK);
		SetLocalInt(OBJECT_SELF, "Cauterized",0);
		SetLocalInt(OBJECT_SELF,"Regrowing",0);
		}
	else if (GetLocalInt(OBJECT_SELF, "Regrowing") == 1) {
		SetLocalInt(OBJECT_SELF,"Regrowing",0);
		ActionSpeakString("Regrows " + IntToString(nRegrow) + " head" + sSRegrown + " from the stump of a damaged one!", TALKVOLUME_TALK);
		nCurrentHeads = GetLocalInt(OBJECT_SELF, "CurrentHeads") + nRegrow;
		SetLocalInt(OBJECT_SELF, "CurrentHeads", nCurrentHeads);
		if(nCurrentHeads > 5) {
			SetBaseAttackBonus(6, OBJECT_SELF);
			}
		else {
			SetBaseAttackBonus(nCurrentHeads, OBJECT_SELF);
			}
	}
}