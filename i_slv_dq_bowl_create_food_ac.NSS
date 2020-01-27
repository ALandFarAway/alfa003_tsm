
#include "acr_spawn_i"
#include "acr_db_persist_i"

void main()
{
             
//OnActivate Script for the quest reward Staff of the Forked Tongue for Wynna's Dean Sphinx quest of 2020
    object oUser = GetItemActivator();
    effect eGlimmer = EffectVisualEffect(VFX_DUR_PIXIEDUST, FALSE);
    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1, FALSE);
    int nRand = Random(20);
	string sRandom;
	int nRandCount = Random(4);
	if(nRand == 1)
		{sRandom = "apple";}
	if(nRand == 2)
		{sRandom = "trailmx";}
	if(nRand == 3)
		{sRandom = "bacon0";}
	if(nRand == 4)
		{sRandom = "broccoli";}
	if(nRand == 5)
		{sRandom = "jerky";}
	if(nRand == 6)
		{sRandom = "egg_boiled";}
	if(nRand == 7)
		{sRandom = "orange";}
	if(nRand == 8)
		{sRandom = "saus020";}
	if(nRand == 9)
		{sRandom = "grape";}
	if(nRand == 10)
		{sRandom = "pie_kidney";}
	if(nRand == 11)
		{sRandom = "pie_dove";}
	if(nRand == 12)
		{sRandom = "potato";}
	if(nRand == 13)
		{sRandom = "blueberry_rm";}
	if(nRand == 14)
		{sRandom = "cbsteak0";}
	if(nRand == 15)
		{sRandom = "meal_fish";}
	if(nRand == 16)
		{sRandom = "tomato";}
	if(nRand == 17)
		{sRandom = "meal_vegsoup";}
	if(nRand == 18)
		{sRandom = "jerky_020";}
	if(nRand == 19)
		{sRandom = "salad";}
	if(nRand == 20)
		{sRandom = "asparagus";}
	
	
	string sFood = "003_it_food_" + sRandom;
	
	SendMessageToPC(oUser, "Food appears in the bowl.");
	CreateItemOnObject(sFood, oUser, nRandCount);	 	 
    
	
	
 
         
   
		  
}