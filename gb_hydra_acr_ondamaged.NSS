//Chop off hydra's heads with damage and set clock ticking on regrowth
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
	int nMaxHP = GetMaxHitPoints(OBJECT_SELF);
	int nAllDmg = GetDamageDealtByType(DAMAGE_TYPE_ALL);
	int nAcid = GetDamageDealtByType(DAMAGE_TYPE_ACID)+1; //returns -1 if none is dealt, 0 if acid damage was dealt, but a very meager amount
	int nFire = GetDamageDealtByType(DAMAGE_TYPE_FIRE)+1;
	int nHeadLossHP = nMaxHP/nHeads;
	int nCurrentHP = GetCurrentHitPoints(OBJECT_SELF);
	int nHeadsLost = StringToInt(GetStringLeft(IntToString(nAllDmg/nHeadLossHP), 1));
	string sSLost = "";
	string sSRegrown = "s";
	
	if((nFire+nAcid)!=0){
		SetLocalInt(OBJECT_SELF, "Cauterized", 1);
		}
		
	
	if(nAllDmg>= nHeadLossHP){
	   if(nHeadsLost > 1) {
		sSLost = "s";
		} 
		SetBaseAttackBonus(nCurrentHeads - nHeadsLost, OBJECT_SELF);
		nCurrentHeads = GetLocalInt(OBJECT_SELF, "CurrentHeads") - nHeadsLost;
		SetLocalInt(OBJECT_SELF, "CurrentHeads", nCurrentHeads);
	    ActionSpeakString("*Loses " + IntToString(nHeadsLost) + " head" + sSLost + "! It now has " + IntToString(nCurrentHeads) + " heads.", TALKVOLUME_TALK);
		SendMessageToAllDMs("*Hydra loses " + IntToString(nHeadsLost) + " head" + sSLost + "! It now has " + IntToString(nCurrentHeads) + " heads.");
		if((nFire+nAcid)==0){
			int nRegrow = 2;
			int nLoop=0;
			while(nLoop<nHeadsLost) {
				if((nHeads*2)-nCurrentHeads < 2) {
					nRegrow = (nHeads*2)-nCurrentHeads < 2;
					}
				if(nRegrow < 2) {
					sSRegrown = "";
				}
				if(nRegrow > 0) {
					int nRegrowRounds = d4(1);
					SetLocalInt(OBJECT_SELF, "Regrowing",1);
					DelayCommand(IntToFloat(nRegrowRounds*6), SetLocalInt(OBJECT_SELF, "Regrowing", 0));
					DelayCommand(IntToFloat(nRegrowRounds*6), ExecuteScript("gb_hydra_regrow",OBJECT_SELF));
					}
				nLoop = nLoop +1;
				}
			}
		}
	
	
	ExecuteScript("acf_cre_ondamaged",OBJECT_SELF);
	
}