//Spawn Undead Proxy that can be destroyed by turning a corpse plc in range

#include "acr_spawn_i"
#include "acr_db_persist_i"
#include "acr_quest_i"
 
void main()
{ SendMessageToAllDMs("onSpawn firing");

  object oMyTrigger = GetNearestObjectByTag("tsm_trg_undead_proxy", OBJECT_SELF,1);
  object oMyCorpse = GetNearestObjectByTag("tsm_plc_undead_proxy", OBJECT_SELF, 1);
  SendMessageToAllDMs("onEnter. oMyTrigger = " + GetName(oMyTrigger) + ". oMyCorpse = " + GetName(oMyCorpse));
  int nAppearance = GetAppearanceType(OBJECT_SELF);	
  SetLocalObject(OBJECT_SELF, "Undead_Proxy_Trg", oMyTrigger);	     
  SetLocalObject(OBJECT_SELF, "Undead_Proxy_Plc", oMyCorpse);	     
  SetLocalObject(oMyTrigger, "Undead_Proxy_Cre", OBJECT_SELF);	     
  SetLocalObject(oMyCorpse, "Undead_Proxy_Cre", OBJECT_SELF);
  SetLocalInt(oMyTrigger, "Appearance", nAppearance);    
  SetLocalInt(oMyCorpse, "Appearance", nAppearance);    
  SendMessageToAllDMs(IntToString(nAppearance)); 
  SetLocalInt(OBJECT_SELF, "Proxy", 1);
  SetLocalInt(oMyCorpse, "Proxy", 1);
  SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_INVALID);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectParalyze(-1,SAVING_THROW_WILL,FALSE),OBJECT_SELF);
}