//For setting SpellSchool variables on an object or item via SLV Uni Wand's conversation

void main(string sVariable, int nValue)
{
	object oTarget = GetItemActivatedTarget();
	location lTarget = GetItemActivatedTargetLocation();
	if(oTarget == OBJECT_INVALID) {oTarget = GetNearestObjectToLocation(OBJECT_TYPE_ALL, lTarget, 1);}
	
	SetLocalInt(oTarget, sVariable, nValue);

 
}