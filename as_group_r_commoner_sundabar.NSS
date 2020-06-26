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

	switch(Random(22)) {
        case 0:
            ACR_SpawnObject("03_cre_sundabar_1", OBJECT_TYPE_CREATURE);
            break;
        case 1:
            ACR_SpawnObject("03_cre_sundabar_2", OBJECT_TYPE_CREATURE);
            break;
        case 2:
            ACR_SpawnObject("03_cre_sundabar_3", OBJECT_TYPE_CREATURE);
            break;
        case 3:
            ACR_SpawnObject("03_cre_sundabar_4", OBJECT_TYPE_CREATURE);
            break;			
	

      case 4:
            ACR_SpawnObject("03_cre_sundabar_5", OBJECT_TYPE_CREATURE);
            break;
        case 5:
            ACR_SpawnObject("03_cre_sundabar_6", OBJECT_TYPE_CREATURE);
            break;
        case 6:
            ACR_SpawnObject("03_cre_sundabar_7", OBJECT_TYPE_CREATURE);
            break;
        case 7:
            ACR_SpawnObject("03_cre_sundabar_8", OBJECT_TYPE_CREATURE);
            break;			
	
	

        case 8:
            ACR_SpawnObject("03_cre_sundabar_9", OBJECT_TYPE_CREATURE);
            break;
        case 9:
           ACR_SpawnObject("03_cre_sundabar_10", OBJECT_TYPE_CREATURE);
            break;
		case 10:
            ACR_SpawnObject("03_cre_sundabar_11", OBJECT_TYPE_CREATURE);
            break;
        case 11:
            ACR_SpawnObject("03_cre_sundabar_12", OBJECT_TYPE_CREATURE);
            break;
       

      case 14:
            ACR_SpawnObject("03_cre_sundabar_13", OBJECT_TYPE_CREATURE);
            break;
        case 15:
            ACR_SpawnObject("03_cre_sundabar_14", OBJECT_TYPE_CREATURE);
            break;
        case 16:
            ACR_SpawnObject("03_cre_sundabar_15", OBJECT_TYPE_CREATURE);
            break;
        case 17:
            ACR_SpawnObject("03_cre_sundabar_16", OBJECT_TYPE_CREATURE);
            break;
			
			
			
			
		case 18:
            ACR_SpawnObject("03_cre_sundabar_smith", OBJECT_TYPE_CREATURE);
            break;
        case 19:
            ACR_SpawnObject("03_cre_sundabar_miner", OBJECT_TYPE_CREATURE);
            break;
        case 20:
            ACR_SpawnObject("03_cre_sundabar_mason", OBJECT_TYPE_CREATURE);
            break;
        case 21:
            ACR_SpawnObject("03_cre_sundabar_engineer", OBJECT_TYPE_CREATURE);
            break;			
	
	//	case 22:
         //   ACR_SpawnObject("003_cr_sundabar_vigilant_01", OBJECT_TYPE_CREATURE);
          //  break;
        //case 23:
         //   ACR_SpawnObject("003_cr_sundabar_stoneshield", OBJECT_TYPE_CREATURE);
        //    break;
         		
	

      	
       
						
}}	
    
			
   