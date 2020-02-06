//Secondary script for all Dean's Exam Static(deandragon) creatures 
//Wynna February 2020


#include "acr_creature_i"
#include "acr_xp_i"
#include "acr_quest_i"


void main()
{
	location lStudent = GetLocation(OBJECT_SELF);
	object oArea = GetArea(OBJECT_SELF);
	vector vPos = Vector(90.0f, 90.0f, 0.0f);
	location lHarpy = Location(oArea, vPos, 90.0); 
	object oWhistle = GetLocalObject(OBJECT_SELF, "oWhistle");
	

	CreateObject(OBJECT_TYPE_CREATURE, "003_slv_dq_h_creature", lHarpy);
	CreateObject(OBJECT_TYPE_CREATURE, "003_slv_dq_h_creature", lHarpy);
	CreateObject(OBJECT_TYPE_CREATURE, "003_slv_dq_h_creature", lHarpy);
	CreateObject(OBJECT_TYPE_CREATURE, "003_slv_dq_h_creature", lHarpy);
	DestroyObject(oWhistle, 5.0);
	
}