////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onenter.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnExit code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2007/01/20  Cipher  Inception
//  Feb 2010 -- Wynna wildmagic onexit
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "acr_quest_i"
#include "acr_spawn_i"
#include "dmfi_inc_langexe" 



void main()
{
    ACR_TriggerOnExit();

    // Custom code goes here.
	

	 

	
 if(GetTag(OBJECT_SELF) == "alfa_wildmagic")
 	{SetLocalInt(GetEnteringObject(), "WildMagic", 0);
	}
	
}