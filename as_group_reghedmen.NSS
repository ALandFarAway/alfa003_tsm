////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Spawn System
//     Filename : as_group_example.nss
//      Version : 1.0
//         Date : 2006-9-17
//       Author : Ronan
//
//  Description
//  This is a simple example of a spawn group script which is used by the ACR's
//  spawn system. Though the name of the script is "as_group_example", the spawn
//  point which uses this script would simply have "example" listed as a spawn
//  group name, since the "as_group_" is always added on to the beginning. For a
//  more complex example of spawn groups, see the script "as_group_complex".
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// This line is required on all spawn group scripts.
#include "acr_spawn_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// This is the main function, which is what the spawn system runs when this
// spawn group is spawned.
void main();

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() {

	switch(Random(5)) {
        case 0:
            ACR_SpawnObject("abr_cr_hu_norsecommonerf", OBJECT_TYPE_CREATURE);
            break;
        case 1:
            ACR_SpawnObject("abr_cr_hu_norsefighterf", OBJECT_TYPE_CREATURE);
            break;
        case 2:
            ACR_SpawnObject("abr_cr_hu_norseguardf", OBJECT_TYPE_CREATURE);
            break;
        case 3:
            ACR_SpawnObject("abr_cr_hu_norsefighterm", OBJECT_TYPE_CREATURE);
            break;
		case 4:
            ACR_SpawnObject("abr_cr_hu_norsemerchantm", OBJECT_TYPE_CREATURE);
            break;
			}			
	

	switch(Random(5)) {
        case 0:
            ACR_SpawnObject("abr_cr_hu_norsescoutf", OBJECT_TYPE_CREATURE);
            break;
        case 1:
            ACR_SpawnObject("abr_cr_hu_norsewarriorf", OBJECT_TYPE_CREATURE);
            break;
        case 2:
            ACR_SpawnObject("abr_cr_hu_norsefighterleader", OBJECT_TYPE_CREATURE);
            break;
       case 3:
            ACR_SpawnObject("abr_cr_hu_norsefighterm", OBJECT_TYPE_CREATURE);
            break;
		case 4:
            ACR_SpawnObject("abr_cr_hu_norsescoutm", OBJECT_TYPE_CREATURE);
            break;
		}			
	
	
	switch(Random(5)) {
        case 0:
            ACR_SpawnObject("abr_cr_hu_norseguardleader", OBJECT_TYPE_CREATURE);
            break;
        case 1:
            ACR_SpawnObject("abr_cr_hu_norsefighterm", OBJECT_TYPE_CREATURE);
            break;
    	case 2:
            ACR_SpawnObject("abr_cr_hu_norseroguef", OBJECT_TYPE_CREATURE);
            break;
        case 3:
            ACR_SpawnObject("abr_cr_hu_norseguardm", OBJECT_TYPE_CREATURE);
            break;
		}	
    
			
	switch(Random(5)) {
         case 0:
            ACR_SpawnObject("abr_cr_hu_norseprincess", OBJECT_TYPE_CREATURE);
            break;
         case 1:
            ACR_SpawnObject("abr_cr_hu_norsewarriorleader", OBJECT_TYPE_CREATURE);
            break;
    	 case 2:
            ACR_SpawnObject("abr_cr_hu_norsescoutleader", OBJECT_TYPE_CREATURE);
            break;
       }	
	
	   switch(Random(5)) {
         case 0:
            ACR_SpawnObject("abr_cr_hu_norseshaman", OBJECT_TYPE_CREATURE);
            break;
         case 1:
            ACR_SpawnObject("abr_cr_hu_norsebardm", OBJECT_TYPE_CREATURE);
            break;
    	 case 2:
            ACR_SpawnObject("abr_cr_hu_norsenobleman", OBJECT_TYPE_CREATURE);
            break;
       }	
			
    
}