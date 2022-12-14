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

	switch(Random(13)) {
        
		case 0:
            ACR_SpawnObject("003_cr_felbarr_dkstn_dig_03", OBJECT_TYPE_CREATURE);
            break;
        case 1:
            ACR_SpawnObject("003_cr_felbarr_dkstn_dig_04", OBJECT_TYPE_CREATURE);
            break;
        case 2:
            ACR_SpawnObject("003_cr_felbarr_dkstn_dig_01", OBJECT_TYPE_CREATURE);
            break;
        case 3:
            ACR_SpawnObject("003_cr_felbarr_dkstn_dig_02", OBJECT_TYPE_CREATURE);
            break;			
	

      	case 4:
            ACR_SpawnObject("003_cr_felbarr_dkstn_eng_01", OBJECT_TYPE_CREATURE);
            break;
        case 5:
            ACR_SpawnObject("003_cr_felbarr_dkstn_eng_02", OBJECT_TYPE_CREATURE);
            break;
        case 6:
            ACR_SpawnObject("003_cr_felbarr_dkstn_eng_03", OBJECT_TYPE_CREATURE);
            break;
        case 7:
            ACR_SpawnObject("003_cr_felbarr_dkstn_eng_04", OBJECT_TYPE_CREATURE);
            break;			
	
	

        case 8:
            ACR_SpawnObject("003_cr_felbarr_dkstn_app_01", OBJECT_TYPE_CREATURE);
            break;
        case 9:
           ACR_SpawnObject("003_cr_felbarr_dkstn_app_02", OBJECT_TYPE_CREATURE);
            break;
		case 10:
            ACR_SpawnObject("003_cr_felbarr_dkstn_app_03", OBJECT_TYPE_CREATURE);
            break;
        case 11:
            ACR_SpawnObject("003_cr_mithall_xbow", OBJECT_TYPE_CREATURE);
            break;
        case 12:
            ACR_SpawnObject("003_cr_mithall_hinf", OBJECT_TYPE_CREATURE);
            break;			
	

     
        case 13:
            ACR_SpawnObject("003_cr_mithall_inf", OBJECT_TYPE_CREATURE);
            break;
						
}}	
    
			
   