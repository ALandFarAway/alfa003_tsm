void main()

{

object oDM = OBJECT_SELF;
object oNPC = GetLocalObject(oDM, "Object_Target");
int nSpell = GetLocalInt(oDM, "omega_cast_spell");
int nCache = GetLocalInt(oDM, "omega_cast_cache");
int nOmega_Target = GetLocalInt(oDM, "omega_cast_target");
int iTarget2 = GetLocalInt(oDM, "omega_secondary_target");
object oTarget2 = GetLocalObject(oDM, "oTarget2");
object oTarget;
location lTarget;

if(nCache == 0)
	{if(iTarget2 == 1)
		{SetLocalObject(oDM, "oTarget2", oNPC);
		 oTarget2 = GetLocalObject(oDM, "oTarget2");
		 SendMessageToPC(oDM, "Spell target cached = " + GetName(oTarget2));
	     return;
		 }
	}
	
if(nOmega_Target == 8)
	{oTarget = oNPC;}
else if(nOmega_Target == 1)
	{oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oNPC, 1);}
else if(nOmega_Target == 2)
	{lTarget = GetLocation(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oNPC, 1));}
else if(nOmega_Target == 3)
	{oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oNPC, 1);}
else if(nOmega_Target == 4)
	{lTarget = GetLocation(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oNPC, 1));}
else if(nOmega_Target == 5)
	{lTarget = GetLocation(oNPC);}
else if(nOmega_Target == 6)
	{oTarget = oTarget2;}
else if(nOmega_Target == 7)
	{lTarget = GetLocation(oTarget);}
else if(nOmega_Target == 0)
	{SendMessageToPC(oDM, "You must pick a target.");}
			
if(nCache == 2)
   {int nCache_Count = 0;
	float fDelay;
	while(nOmega_Target != 0)
	   {if(nOmega_Target == 8)
			{DelayCommand(fDelay, AssignCommand(oNPC, ActionCastSpellAtObject(nSpell, oTarget, -1, 1, 0, PROJECTILE_PATH_TYPE_DEFAULT, 1)));
		   }
		else if(nOmega_Target == 1)
			{DelayCommand(fDelay, AssignCommand(oNPC, ActionCastSpellAtObject(nSpell, oTarget, -1, 1, 0, PROJECTILE_PATH_TYPE_DEFAULT, 1)));
		    }
		else if(nOmega_Target == 2)
			{DelayCommand(fDelay, AssignCommand(oNPC, ActionCastSpellAtLocation(nSpell, lTarget, -1, 1, 0, PROJECTILE_PATH_TYPE_DEFAULT, 1)));
			}
		else if(nOmega_Target == 3)
			{DelayCommand(fDelay, AssignCommand(oNPC, ActionCastSpellAtObject(nSpell, oTarget, -1, 1, 0, PROJECTILE_PATH_TYPE_DEFAULT, 1)));
		   }
		else if(nOmega_Target == 4)
			{DelayCommand(fDelay, AssignCommand(oNPC, ActionCastSpellAtLocation(nSpell, lTarget, -1, 1, 0, PROJECTILE_PATH_TYPE_DEFAULT, 1)));
			}
		else if(nOmega_Target == 5)
			{DelayCommand(fDelay, AssignCommand(oNPC, ActionCastSpellAtLocation(nSpell, lTarget, -1, 1, 0, PROJECTILE_PATH_TYPE_DEFAULT, 1)));
		   }
		else if(nOmega_Target == 6)
			{DelayCommand(fDelay, AssignCommand(oNPC, ActionCastSpellAtObject(nSpell, oTarget, -1, 1, 0, PROJECTILE_PATH_TYPE_DEFAULT, 1)));
		   }
			
		else if(nOmega_Target == 7)
			{DelayCommand(fDelay, AssignCommand(oNPC, ActionCastSpellAtLocation(nSpell, lTarget, -1, 1, 0, PROJECTILE_PATH_TYPE_DEFAULT, 1)));
			}
		
		
		nOmega_Target = GetLocalInt(oNPC, "Omega_Cache_Target_" + IntToString(nCache_Count));
	    nSpell = GetLocalInt(oNPC, "Omega_Cache_Spell_" + IntToString(nCache_Count));
 	    SetLocalInt(oNPC, "Omega_Cache_Target_" + IntToString(nCache_Count), 0);
		SetLocalInt(oNPC, "Omega_Cache_Spell_" + IntToString(nCache_Count), 999999999);
		fDelay = fDelay + 6.0;
		nCache_Count++;
		
		}
	SetLocalInt(oTarget, "nCache_Count", 0);
	SetLocalInt(oDM, "omega_cast_cache", 0);
    SetLocalInt(oDM, "omega_cast_target", 0);
    SetLocalInt(oDM, "omega_cast_spell", 999999999);
     	
	}
	
if(nCache == 1)
		{
		
		 int nCache_Count = GetLocalInt(oNPC, "nCache_Count");
		 SetLocalInt(oNPC, "Omega_Cache_Target_" + IntToString(nCache_Count), nOmega_Target);
		 SetLocalInt(oNPC, "Omega_Cache_Spell_" + IntToString(nCache_Count), nSpell);
		 nCache_Count++;
		 SetLocalInt(oNPC, "nCache_Count", nCache_Count);
		 
		}

}		