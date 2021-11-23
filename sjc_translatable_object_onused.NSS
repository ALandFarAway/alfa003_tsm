#include "acr_language_i"
void main() {
      object oPlaceable = OBJECT_SELF;
      object oUser = GetLastUsedBy();
      if(ACR_IsLanguageKnown(oUser, GetLocalString(oPlaceable, "SJC_PLC_LANG"))) 
	 	 {SendMessageToPC( oUser, GetLocalString( oPlaceable, "SJC_TRANSLATED_TEXT" ));
      	  if(GetTag(OBJECT_SELF) == "hf_plc_scale_placard") {
	 		SendMessageToPC( oUser, "For a moment, you feel very small, as if something huge had suddenly appeared, but you see nothing.");
      	    if(WillSave(oUser, 20, SAVING_THROW_TYPE_SPELL, OBJECT_SELF) == 0) {
				DelayCommand(2.0, SendMessageToPC( oUser, "The glittering hide stretched over the placard comes away in your hand."));
			 	}
			else {
				DelayCommand(2.0, SendMessageToPC( oUser, "The glittering hide stretched over the placard comes away in your hand."));
			 	}
		 	CreateItemOnObject("abr_it_ms_forestsong", oUser, 1);
			DestroyObject(OBJECT_SELF, 3.0);
           } 
	  else 
	  	{
           SendMessageToPC( oUser, GetLocalString( oPlaceable, "SJC_FAILED_TEXT" ) );
     	 }
		 
	 
 }
 
 }