//Secondary script for all Dean's Exam Static(deandragon) creatures 
//Wynna February 2020


#include "acr_creature_i"
#include "acr_xp_i"
#include "acr_quest_i"
#include "acr_position_i"

void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}

void main()
{	object oStudent = OBJECT_SELF;
	location lStudent = GetLocation(OBJECT_SELF);
	vector vStudent = GetPosition(OBJECT_SELF);
	object oArea = GetArea(OBJECT_SELF);
	object oWhistle = GetLocalObject(OBJECT_SELF, "oWhistle");
	
	if(GetLocalInt(oStudent, "HarpyMsg")==2)  {
		if(((FindSubString(GetTag(oArea), "_ext_") != -1) || (FindSubString(GetTag(oArea), "_xyz") != -1) || (FindSubString(GetTag(oArea), "_ferry") != -1)) && (GetIsSkillSuccessful(OBJECT_SELF, SKILL_SPOT,20,TRUE))) {
			SendMessageToPC(oStudent, "The sense of coming doom continues to grow. You feel marked. Far, far off over the northern horizon, specks pepper the sky. Too small for even the best eyes to make out, perhaps even your imagination.");	  
			SetLocalInt(oStudent, "HarpySpot", 1);
			}
		else if((FindSubString(GetTag(oArea), "_int_") != -1) || (FindSubString(GetTag(oArea), "travel_") != -1)) {
			SendMessageToPC(oStudent, "The sense of coming doom continues to grow. You feel marked.");	  
			}
		}
	
	if(GetLocalInt(oStudent, "HarpyMsg")==3) {
		if(FindSubString(GetTag(oArea), "_ext_") != -1) {
			if(GetLocalInt(oStudent, "HarpySpot") == 1) {
				SendMessageToPC(oStudent, "Those specks are not your imagination. They are growing, clearly winged figures too large for birds, a flock of something speeding in your direction. How many is hard to tell. A handful? A distant shriek floats ahead of them, chilling your blood.");	  
				}
			else if((GetLocalInt(oStudent, "HarpySpot") == 0) && (GetIsSkillSuccessful(OBJECT_SELF, SKILL_SPOT,15,TRUE))) {
				SendMessageToPC(oStudent, "The sense of coming doom continues to grow. You feel marked. Movement to the north catches your eye, specks rapidly growing into winged figures too large for birds.");	  
				SetLocalInt(oStudent, "HarpySpot", 1);
			 	}
			else   {
				SendMessageToPC(oStudent, "The sense of coming doom continues to grow.");	  
				SetLocalInt(oStudent, "HarpySpot", 1);
			 	}
			}
		else if(FindSubString(GetTag(oArea), "_int_") != -1)  {
			SendMessageToPC(oStudent, "Anxiety rises. You feel confined, trapped inside. The echo of the whistle seems to shriek again in your ears.");	  
			}
		
		}
	
	if(GetLocalInt(oStudent, "HarpyMsg")==4) {
		if(FindSubString(GetTag(oArea), "_ext_") != -1)  {
			if(GetLocalInt(oStudent, "HarpySpot") == 1) {
				SendMessageToPC(oStudent, "The oncoming flying creatures are close enough that you can see what you are about to face. Harpies.");	  
				}
			else if((GetLocalInt(oStudent, "HarpySpot") == 0) && (GetIsSkillSuccessful(OBJECT_SELF, SKILL_SPOT,10,TRUE))) {
				SendMessageToPC(oStudent, "Movement in the sky draws your eyes to flying creatures. Winged women. Harpies!");	  
				SetLocalInt(oStudent, "HarpySpot", 1);
			 	}
			}
		else if(FindSubString(GetTag(oArea), "_int_") != -1)  {
			SendMessageToPC(oStudent, "A harsh shriek sounds outside, a woman's scream of anger.");	  
			}
			
			
		}
	
	if(GetLocalInt(oStudent, "HarpyMsg")==5) {
		if(FindSubString(GetTag(oArea), "_ext_") != -1)  {
			if(GetLocalInt(oStudent, "HarpySpot") == 1) {
				SendMessageToPC(oStudent, "Harpies swoop upon you from multiple directions!");	  
				}
			else if(GetLocalInt(oStudent, "HarpySpot") == 0) {
				SendMessageToPC(oStudent, "A tangle of greasy wings and shrieking voices sets upon you from the air.");	  
				SetLocalInt(oStudent, "HarpySpot", 1);
			 	}
			
			DelayCommand(2.0, ActionCreateCreature("003_cr_scry_send_xavier", lStudent));
			DelayCommand(7.0, ActionCreateCreature("003_slv_dq_h_creature", GetLocation(GetNearestObject(OBJECT_TYPE_CREATURE, oStudent, 1))));
			DelayCommand(10.0, ActionCreateCreature("003_slv_dq_h_creature", lStudent));
	 		DelayCommand(15.0, SetLocalInt(oStudent, "HarpyMsg", 6));
			}
			
		else if(FindSubString(GetTag(oArea), "_int_") != -1)  {
			SendMessageToPC(oStudent, "Shrieks sounds outside, grating cackles of crazed rage, followed by terrified cries and screams, and the sound of fleeing commoners.");	  
			
			}
		
		}
	
		
	
	
	
	
}