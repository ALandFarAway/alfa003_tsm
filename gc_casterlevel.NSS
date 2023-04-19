// gc_casterlevel(int nClass, string sLevelCheck, string sTarget)
/*
	This script checks to see if a character has a certain number of caster levels.
	Parameters:
    int nClass  		   = The CLASS_TYPE_* integer of the class to check for.
    string sLevelCheck 	   = The level to check for this class.
						     You can specify <, >, =, or !
                             e.g. sLevelCheck of "<12" returns TRUE if level in the class is <12
                             a sLevelCheck of "9" or "=9" returns TRUE if level in the class is exactly 9
                             and a sLevelCheck of "!0" returns TRUE if level in the class is not equal to 0.
                             Default value if left blanck is "!0"
    string sTarget    	   = Tag or identifier of Target. If blank then use PC Speaker.
	int nIgnoreBonusLevels = Mask for ingored bonus levels, 1 is Practiced Spell Caster, 2 is Red Wizard Spell Power, 3 is both
		
	Example 1:
	Check if PC Speaker is a wizard (has any levels of wizard):
	gc_casterlevel(10, "", "")

	Example 2:
	Check if PC Speaker is at least a caster level 15 wizard without practiced spell caster or red wizard bonuses:
	gc_casterlevel(10, ">14", "", 3)

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

#include "ginc_var_ops"
#include "ginc_param_const"
#include "ginc_2da"

// GetCasterLevelByClass(int nClassType, object oCreature=OBJECT_SELF, int nIgnoreBonusLevels=0x0)
// bonus levels are those from practiced spell caster, limit to total levels, and red wizards spell power for wizard spells only
// Ignoring bonus levels is a bit mask, 0x1 is practiced spell caster 0x2 is red wizard so 0x3 would be ignore both
int GetCasterLevelByClass(int nClassType, object oCreature=OBJECT_SELF, int nIgnoreBonusLevels=0x0)
{
	int nCasterLevel = GetLevelByClass(nClassType, oCreature);
	if (nCasterLevel < 1) return 0;
	string sClassLabel = GetStringUpperCase(Get2DAString("classes","Label",nClassType)); 
	int nClassPosition; 
	// checking 1 is unnecessary for PCs as it's always a base class
	for (nClassPosition = (GetIsPC(oCreature))?2:1; nClassPosition <= 4; ++nClassPosition) { 
		int nClass = GetClassByPosition(nClassPosition);
		if (nClass == CLASS_TYPE_INVALID) continue;
		string sFeatsTable = Get2DAString("classes","FeatsTable",nClass);
		int nRow;
		for (nRow = GetNum2DARows(sFeatsTable) - 1; nRow >= 0; --nRow) {
			if (!GetHasFeat(Get2DAInt(sFeatsTable,"FeatIndex",nRow),oCreature)) continue;
			// all the bonus spell casting level feats are labeled with "_SPELLCASTING_CLASS"
			// theses seems to be the only way to identify them from the 2da files
			string sFeatLabel = GetStringUpperCase(Get2DAString(sFeatsTable,"FeatLabel",nRow));	
			if (FindSubString(sFeatLabel,"_SPELLCASTING_") < 0) continue;
			if (FindSubString(sFeatLabel,sClassLabel) < 0) continue;
		}
	}
	// do not ignore practiced spell caster
	if ((nIgnoreBonusLevels & 0x1 != 0x1) 
		&& GetHasFeat(Get2DAInt("classes","nFEATPracticedSpellCaster",nClassType),oCreature)) {
	 	nCasterLevel += 4;
		int nMaxCasterLevel = GetTotalLevels(oCreature,TRUE);
		if (nCasterLevel > nMaxCasterLevel) nCasterLevel = nMaxCasterLevel;
	}
	// From d20srd "a Red Wizard gains a bonus that increases his effective caster level for purposes of determining level-dependent spell variables and for caster level checks."
	// There is no mention of it being restricted to class or specialization
	if (nIgnoreBonusLevels & 0x2 != 0x2) { // do not ignore red wizard spell power
		if (GetHasFeat(1885,oCreature)) nCasterLevel += 5;
		else if (GetHasFeat(1884,oCreature)) nCasterLevel += 4;
		else if (GetHasFeat(1883,oCreature)) nCasterLevel += 3;
		else if (GetHasFeat(1882,oCreature)) nCasterLevel += 2;
		else if (GetHasFeat(1881,oCreature)) nCasterLevel += 1;
	}
	return nCasterLevel;
}

int StartingConditional(int nClass, string sLevelCheck, string sTarget, int nIgnoreBonusLevels)
{
    object oTarget = GetTarget(sTarget, TARGET_PC_SPEAKER);

	int nCasterLevel = GetCasterLevelByClass(nClass, oTarget);
	if (sLevelCheck == "")
		sLevelCheck = "!0";
	
    int nRet = CompareInts(nCasterLevel, sLevelCheck);

	return (nRet);
}