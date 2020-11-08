#include "acr_spawn_i"
#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "acr_quest_i"
 
void main()
{

	effect eKnockdown = EffectKnockdown();
	
	object oTarget = GetItemActivatedTarget();
	int iLieDown = GetLocalInt(oTarget, "iWandLieDown");
	if(iLieDown == 0)
		{SetLocalInt(oTarget, "iWandLieDown", 1);
		 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oTarget, 360000.0);}
	else if(iLieDown == 1)
		{SetLocalInt(oTarget, "iWandLieDown", 0);
		 RemoveEffect(oTarget, eKnockdown);
			 if(GetIsPC(oTarget) != TRUE)
			 	{int iHealth = GetCurrentHitPoints(oTarget);
				 int iHP = GetMaxHitPoints(oTarget);
				 int iDmg = iHP - iHealth;
				 effect eDamage = EffectDamage(iDmg, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_NORMAL, TRUE);
				 object oNew = CreateObject(OBJECT_TYPE_CREATURE, GetResRef(oTarget), GetLocation(oTarget));
			 	 DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oNew));
				 DestroyObject(oTarget);
				 }
		}
					      
   }