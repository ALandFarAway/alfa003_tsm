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
// Rick: Added wild horses and deer herds.
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

	switch(Random(13)) {
        case 0:
            ACR_SpawnObject("abr_cr_an_wild_badger", OBJECT_TYPE_CREATURE);
            break;
        case 1:
            ACR_SpawnObject("abr_cr_an_wild_deer_stag", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("abr_cr_an_wild_deer_doe", OBJECT_TYPE_CREATURE);
            break;
        case 2:
            ACR_SpawnObject("abr_cr_an_wild_rabbit", OBJECT_TYPE_CREATURE);
            break;
        case 3:
            ACR_SpawnObject("abr_cr_an_wild_deer_stag", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("abr_cr_an_wild_deer_doe", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("abr_cr_an_wild_deer_fawn", OBJECT_TYPE_CREATURE);
			
			
            break;			
	

      case 4:
            ACR_SpawnObject("abr_cr_an_wild_bird", OBJECT_TYPE_CREATURE);
            break;
        case 5:
            ACR_SpawnObject("abr_cr_an_wild_horse", OBJECT_TYPE_CREATURE);	
            break;
        case 6:
            ACR_SpawnObject("abr_cr_an_wild_horse", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("abr_cr_an_wild_horse", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("abr_cr_an_wild_horse_stallion", OBJECT_TYPE_CREATURE);	
            break;
        case 7:
            ACR_SpawnObject("abr_cr_an_wild_rabbit", OBJECT_TYPE_CREATURE);
            break;			
	
	

        case 8:
            ACR_SpawnObject("abr_cr_an_wild_weasel", OBJECT_TYPE_CREATURE);
            break;
        case 9:
           ACR_SpawnObject("abr_cr_an_wild_rabbit", OBJECT_TYPE_CREATURE);
            break;
		case 10:
           ACR_SpawnObject("abr_cr_an_wild_badger", OBJECT_TYPE_CREATURE);
            break;
		case 11:
           ACR_SpawnObject("abr_cr_an_wild_horse_stallion", OBJECT_TYPE_CREATURE);
            break;
		case 12:
           ACR_SpawnObject("abr_cr_an_wild_deer_stag", OBJECT_TYPE_CREATURE);
            break;		
			
			}
}	
    
			
   