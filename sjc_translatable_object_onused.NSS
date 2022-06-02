#include "acr_language_i"
void main() {
      object oPlaceable = OBJECT_SELF;
      object oUser = GetLastUsedBy();
	  if((GetTag(OBJECT_SELF) == "rr_plc_book_hieroglyph") && (!ACR_IsLanguageKnown(oUser, LNG_MULHORANDI))) {
		    ACR_GrantLanguage(oUser, LNG_MULHORANDI);
			SendMessageToPC(oUser, "The hieroglyphs resolve into meaning in your thoughts, and you find yourself able to speak and read Mulhorandi.");
	 		}
      if(ACR_IsLanguageKnown(oUser, GetLocalString(oPlaceable, "SJC_PLC_LANG"))) 
	 	 {SendMessageToPC( oUser, GetLocalString( oPlaceable, "SJC_TRANSLATED_TEXT" ));
      	  if(GetTag(OBJECT_SELF) == "rr_plc_book_hieroglyph") {
		    ActionSpeakString("I was Gyasi Sayen, House of the Scions, theurge of Horus-Re. **The voice issues from behind the unmoving grin of a skull atop the book of hieroglyphs.", TALKVOLUME_TALK);
      	    DelayCommand(2.0, ActionSpeakString("My family would say that I stole the Crown of Scions and fled Mulhorand. The provenance of what I have done is unimportant. It was done, and that is all.", TALKVOLUME_TALK));
      	    DelayCommand(4.0, ActionSpeakString("Westward I came, and north. When I found that the sun also shines where I thought it set, I stopped, and fell into despondency. When I rose from grief, I found tasks for which I was suited, in lands where races mingled without hierarchy or castes. In this way, brought I one of the crowns of the Kingdom of Phalorm.", TALKVOLUME_TALK));
      	    DelayCommand(6.0, ActionSpeakString("Solace there was in destroying what threatened my new home. I enslaved myself to this new house, this new purpose. I learned new magics. I took new gods.  When the end came, I would not recognize it. I could not lose another home. Iniarv that laid waste the armies of Phalorm would not destroy her soul. Like Osiris, that fell, Phalorm would rise again.", TALKVOLUME_TALK));
      	    DelayCommand(8.0, ActionSpeakString("Three wizards survived, and we would do mighty magics to restore the dream that was Phalorm.  Each of us bore our crowns further north, in search of the dwarf's crystal magic and the elf's high magics, that like our kingdom we would merge into a whole the stronger for its parts. A cursed goal, modeled on a fallen dream.", TALKVOLUME_TALK));
      	    DelayCommand(10.0, ActionSpeakString("Glandargloht found her crystals and Ilphelkiir what was left of his high magics, both warped by what had befallen them. Fitting counterparts to what I brought.", TALKVOLUME_TALK));
      	    DelayCommand(12.0, ActionSpeakString("As we forged our separate offerings, I blocked from memory the cries of the harpies that had chased me from Mulhorand, shrieking that my inheritance would be thereafter cursed.", TALKVOLUME_TALK));
      	    DelayCommand(14.0, ActionSpeakString("I blamed my family, rightly so, but the elf and dwarf saw no difference between me and those who had leveled that curse. Indeed, they gave me more than my fair share of responsibility, for were not their own crowns corrupted? Ilphelkiir with his brooding on Eaerlann and meddling in the snows, and the dwarf with her anger at the unpredictable consequences of her carelessness with her own people's crystals, they failed too.", TALKVOLUME_TALK));
      	    DelayCommand(16.0, ActionSpeakString("I forgave them, even when they argued against the path we could have taken to restore the dead, our friends and family and brave warriors of Phalorm. WIth the power of the Three Crowns, we could have -- I could have -- safeguarded their souls. Only I had the power, the training, and the potential to bring them all back.", TALKVOLUME_TALK));
      	    DelayCommand(18.0, ActionSpeakString("All we had to do was to carry the souls necessary to the rebirth of the Fallen Kingdom to Mulhorand, reclaim my birthright, and command the priests of gods subservient to Horace-Re to ressurect them in their hundreds.", TALKVOLUME_TALK));
      	    DelayCommand(20.0, ActionSpeakString("They refused to believe House Sayan of Horace-Re had such power. The dwarf looked askance; the elf had seen kingdoms fall before. In a foul action, they imposed a geas upon me unsuspecting, to return to my redoubt with my retinue and unmake what I had made. They should not have done so.", TALKVOLUME_TALK));
      	    DelayCommand(22.0, ActionSpeakString("The Orb of Nature and Life I leave upon an altar surrounded by the sentient stone trees Glandarghlot sent to ensure that I did so. After years of use by my powers, it sends out a subtle call to those attuned to Conjuration. When an arcanist of comparitive power responds to that call, it will whisper secrets of Osiris' power over life, death and undeath, and where to find me.", TALKVOLUME_TALK));
      	    DelayCommand(24.0, ActionSpeakString("Still within my erstwhile compatriots' compelling geas, here I document the Ritual of Unmaking. With it, of my own summoned volition, I also set down the Ritual of Making, for you, who read this, and so must wield the Orb of Nature and Life.  Do what it has told you.  Crown the Scion, that wrongs may be redressed.", TALKVOLUME_TALK));
      	    } 
		   }
	  else 
	  	{
           SendMessageToPC( oUser, GetLocalString( oPlaceable, "SJC_FAILED_TEXT" ) );
     	 }
		 
	 
 
 
 }