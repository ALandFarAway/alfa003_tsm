//Spawn Undead Proxy that can be destroyed by turning a corpse plc in range

#include "acr_spawn_i"
#include "acr_db_persist_i"
#include "acr_quest_i"
 
void main()
{ SendMessageToAllDMs("onSpawn firing");

  object oMyTrigger = GetNearestObjectByTag("tsm_trg_undead_proxy", OBJECT_SELF,1);
  object oMyCorpse = GetNearestObjectByTag("tsm_plc_undead_proxy", OBJECT_SELF, 1);
  int nAppearance = GetAppearanceType(OBJECT_SELF);	
  effect eParalyze = EffectCutsceneParalyze();
  int nRate = GetMovementRate(OBJECT_SELF);
  effect eInvisible = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY, FALSE);
  SendMessageToAllDMs("onSpawn. oMyTrigger = " + GetName(oMyTrigger) + ". oMyCorpse = " + GetName(oMyCorpse) + ". Movement rate = " + IntToString(nRate));
  SetLocalObject(OBJECT_SELF, "Undead_Proxy_Trg", oMyTrigger);	     
  SetLocalObject(OBJECT_SELF, "Undead_Proxy_Plc", oMyCorpse);	     
  SetLocalObject(oMyTrigger, "Undead_Proxy_Cre", OBJECT_SELF);	     
  SetLocalObject(oMyCorpse, "Undead_Proxy_Cre", OBJECT_SELF);
  SetLocalInt(oMyTrigger, "Appearance", nAppearance);    
  SetLocalInt(oMyTrigger, "Rate", nRate);    
  SetLocalInt(oMyCorpse, "Appearance", nAppearance);    
  SetLocalInt(OBJECT_SELF, "Proxy", 1);
  SetLocalInt(oMyCorpse, "Proxy", 1);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, OBJECT_SELF);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvisible, OBJECT_SELF);
  SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_INVALID);
  
  }