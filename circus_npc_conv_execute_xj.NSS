//Conversation driven for Jenny's circus act
//Wynna May 2015


void ActionCreateWynPlace(string sPlace, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlace, lLocPlace);
}

void ActionCreateWynPlacedEffect(string sPlacedEffect, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sPlacedEffect, lLocPlace);
}

void ReallyPlayCustomAnimation(object oObject, string sAnimationName, int nLooping, float fSpeed = 1.0f)
 {
    PlayCustomAnimation(oObject, sAnimationName, nLooping, fSpeed);
 }
 
void main()
{
		 
	
	//Water Genasi Acrobat	
	if((GetTag(OBJECT_SELF) == "003_cr_circus_jenny") && (GetTag(GetArea(OBJECT_SELF)) == "003_travelling_circus_int_bigtp"))
			{	object oXavier = GetObjectByTag("003_cr_firegen_xavier", 0);
		 			  object oJenny = OBJECT_SELF;
					  object oLadderCenterWestUp = GetWaypointByTag("003_plc_circus_ladder_cw_up_WP");
					  location lLadderCenterWestUp = GetLocation(oLadderCenterWestUp);
					  object oLadderCenterWestDown = GetWaypointByTag("003_plc_circus_ladder_cw_dn_WP");
					  location lLadderCenterWestDown = GetLocation(oLadderCenterWestDown);
					  object oLute = GetItemPossessedBy(oXavier, "abr_it_msc_lute");
					  
					 
					  DelayCommand(1.0, AssignCommand(oXavier, ActionCastSpellAtObject(SPELL_EAGLES_SPLENDOR, oJenny, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
					  DelayCommand(3.0, AssignCommand(oJenny, SetFacing(DIRECTION_SOUTH, FALSE)));
					  DelayCommand(4.0, AssignCommand(oJenny, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0, 2.0)));
					  DelayCommand(4.0, AssignCommand(oJenny, ActionWait(2.0)));
					  DelayCommand(6.0, AssignCommand(oJenny, ActionForceMoveToLocation(lLadderCenterWestDown, TRUE, 30.0)));
					  DelayCommand(7.0, AssignCommand(oJenny, SetFacing(DIRECTION_SOUTH, FALSE)));
					  DelayCommand(9.0, AssignCommand(oJenny, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE, 1.0, 2.0)));
					  DelayCommand(9.0, AssignCommand(oJenny, ActionWait(1.0)));
					  DelayCommand(10.0, AssignCommand(oJenny, SetFacing(DIRECTION_NORTH, FALSE)));
					  DelayCommand(11.0, AssignCommand(oJenny, ActionPlayAnimation(ANIMATION_FIREFORGET_BARDSONG, 1.0, 2.0)));
					  DelayCommand(11.0, AssignCommand(oJenny, ActionWait(1.0)));
					  DelayCommand(11.0, AssignCommand(oXavier, SetFacing(DIRECTION_SOUTH, FALSE)));
					  DelayCommand(12.0, AssignCommand(oJenny, ActionSpeakString("*Climbs.*", TALKVOLUME_TALK)));
					  DelayCommand(12.0, AssignCommand(oXavier, ActionCastSpellAtObject(SPELL_JOYFUL_NOISE, oXavier, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
					  DelayCommand(13.0, AssignCommand(oXavier, ActionEquipItem(oLute, INVENTORY_SLOT_RIGHTHAND)));
					  DelayCommand(14.0, AssignCommand(oJenny, ActionJumpToLocation(lLadderCenterWestUp)));
					 
					   
					  DelayCommand(15.0, AssignCommand(oXavier, ActionPlayAnimation(ANIMATION_LOOPING_GUITARPLAY, 1.0, 3.0)));
			 		  DelayCommand(15.0, AssignCommand(oXavier, PlaySound("as_cv_lute1", FALSE)));
			          DelayCommand(15.5, AssignCommand(oXavier, ActionWait(3.0)));
					  DelayCommand(15.0, AssignCommand(oJenny, ActionPlayAnimation(ANIMATION_FIREFORGET_BARDSONG, 1.0, 2.0)));
					  DelayCommand(15.0, AssignCommand(oJenny, ActionWait(1.0)));
					  DelayCommand(16.0, AssignCommand(oJenny, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0)));
					  DelayCommand(16.0, AssignCommand(oJenny, ActionWait(1.0)));
					  DelayCommand(16.0, AssignCommand(oXavier, ActionPlayAnimation(ANIMATION_LOOPING_GUITARPLAY, 1.0, 3.0)));
			 		  DelayCommand(16.0, AssignCommand(oXavier, PlaySound("as_cv_lute1", FALSE)));
			          DelayCommand(16.0, AssignCommand(oXavier, ActionWait(3.0)));
					  DelayCommand(18.0, AssignCommand(oJenny, ActionPlayAnimation(ANIMATION_FIREFORGET_DRUMIDLEFIDGET, 1.0, 2.0)));
					  DelayCommand(18.0, AssignCommand(oJenny, ActionWait(1.0)));
					  DelayCommand(20.0, AssignCommand(oXavier, ActionSpeakString("*Speaks rhythmically, in a deep, resonant voice.*", TALKVOLUME_TALK)));
					  DelayCommand(21.0, ExecuteScript("circus_npc_conv_execute_xj1", oJenny));
					  
		}
}			 			 