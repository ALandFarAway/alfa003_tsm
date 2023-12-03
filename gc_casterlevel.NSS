// gc_casterlevel(int nClass, int nLevel, int nIgnoreBonusLevels)
/*
	This script checks to see if a character has a certain number of caster levels.
	Parameters:
    int nClass  		   = The CLASS_TYPE_* integer of the class to check for.
	int nLevel             = The minimum level to check for
	int nIgnoreBonusLevels = Mask for ingored bonus levels, 1 is Practiced Spell Caster, 2 is Red Wizard Spell Power, 3 is both
		
	Example 1:
	Check if PC Speaker is a wizard (has any levels of wizard):
	gc_casterlevel(10, 1, 0)

	Example 2:
	Check if PC Speaker is at least a caster level 15 wizard without practiced spell caster or red wizard bonuses:
	gc_casterlevel(10, 14, 3)

int CLASS_TYPE_BARD      = 1;
int CLASS_TYPE_CLERIC    = 2;
int CLASS_TYPE_DRUID     = 3;
int CLASS_TYPE_PALADIN   = 6;
int CLASS_TYPE_RANGER    = 7;
int CLASS_TYPE_SORCERER  = 9;
int CLASS_TYPE_WIZARD    = 10;
int CLASS_TYPE_WARLOCK	 = 39;

int CLASS_TYPE_SPIRIT_SHAMAN 	= 55
int CLASS_TYPE_FAVORED_SOUL 	= 58


*/
// ELM 4/18/23

#include "ginc_2da"

// GetCasterLevelByClass(int nClassType, object oCreature=OBJECT_SELF, int nIgnoreBonusLevels=0x0)
// bonus levels are those from practiced spell caster, limit to total levels, and red wizards spell power for wizard spells only
// Ignoring bonus levels is a bit mask, 0x1 is practiced spell caster 0x2 is red wizard so 0x3 would be ignore both
int GetCasterLevelByClass(int nClassType, object oCreature, int nIgnoreBonusLevels)
{
	int nCasterLevel = GetLevelByClass(nClassType, oCreature);
//	SendMessageToPC(oCreature,"Class "+IntToString(nClassType));
//	SendMessageToPC(oCreature,"Base Level "+IntToString(nCasterLevel));	
	if (nCasterLevel < 1) return 0;
//	string sClassLabel = GetStringUpperCase(Get2DAString("classes","Label",nClassType)); 
	int nClassPosition; 
	// checking 1 is unnecessary for PCs as it's always a base class
	for (nClassPosition = (GetIsPC(oCreature))?2:1; nClassPosition <= 4; ++nClassPosition) { 
		int nClass = GetClassByPosition(nClassPosition,oCreature);
//		SendMessageToPC(oCreature,"Checking class "+IntToString(nClass));			
		if (nClass == CLASS_TYPE_INVALID) continue;
		string sFeatsTable = Get2DAString("classes","FeatsTable",nClass);
		int nRow;
		for (nRow = GetNum2DARows(sFeatsTable) - 1; nRow >= 0; --nRow) {
			int nFeat = Get2DAInt(sFeatsTable,"FeatIndex",nRow);
			if (!GetHasFeat(nFeat,oCreature)) continue;
//			SendMessageToPC(oCreature,"Checking feat "+IntToString(nFeat));			
			// all the bonus spell casting level feats are labeled with "_SPELLCASTING_"
			// this seems to be the only way to identify them from the 2da files
			string sFeatLabel = GetStringUpperCase(Get2DAString(sFeatsTable,"FeatLabel",nRow));	
			if (FindSubString(sFeatLabel,"_SPELLCASTING_") < 0) continue;
			int nSpellCastingClass = Get2DAInt("feat","MinLevelClass",nFeat);
			if (nSpellCastingClass != nClassType) continue;
			string sSpellGainTable = Get2DAString("classes","BonusSpellcasterLevelTable",nClass);
			int nLevelRow;
			for(nLevelRow = GetLevelByPosition(nClassPosition,oCreature) - 1; nLevelRow >= 0; -- nLevelRow)
				nCasterLevel += Get2DAInt(sSpellGainTable,"GrantsBonusSpellcasterLevel",nLevelRow);
//			SendMessageToPC(oCreature,"With class "+IntToString(nClass)+" Level "+IntToString(nCasterLevel));	
		}
	}
	// do not ignore practiced spell caster
	if ((nIgnoreBonusLevels & 0x1 != 0x1) 
		&& GetHasFeat(Get2DAInt("classes","FEATPracticedSpellCaster",nClassType),oCreature)) {
	 	nCasterLevel += 4;
		int nMaxCasterLevel = GetTotalLevels(oCreature,TRUE);
		if (nCasterLevel > nMaxCasterLevel) nCasterLevel = nMaxCasterLevel;
//		SendMessageToPC(oCreature,"With practiced spell caster "+IntToString(nCasterLevel));	
	}
	// From d20srd "a Red Wizard gains a bonus that increases his effective caster level for purposes of determining level-dependent spell variables and for caster level checks."
	// There is no mention of it being restricted to class or specialization
	if (nIgnoreBonusLevels & 0x2 != 0x2) { // do not ignore red wizard spell power
		if (GetHasFeat(1885,oCreature)) nCasterLevel += 5;
		else if (GetHasFeat(1884,oCreature)) nCasterLevel += 4;
		else if (GetHasFeat(1883,oCreature)) nCasterLevel += 3;
		else if (GetHasFeat(1882,oCreature)) nCasterLevel += 2;
		else if (GetHasFeat(1881,oCreature)) nCasterLevel += 1;
//		SendMessageToPC(oCreature,"With red wizard spell power "+IntToString(nCasterLevel));	
	}
	return nCasterLevel;
}

int StartingConditional(int nClass, int nLevel, int nIgnoreBonusLevels)
{
    object oTarget = GetPCSpeaker();

	int nCasterLevel = GetCasterLevelByClass(nClass, oTarget, nIgnoreBonusLevels);

//	SendMessageToPC(oTarget,"Total caster level "+IntToString(nCasterLevel));	
	return (nCasterLevel>=nLevel);
}