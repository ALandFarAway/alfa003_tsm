#include "acr_tools_i"
#include "acr_zspawn_i"
#include "00_namegen_i"

const float _SIZE_STD_X = 0.04f;
const float _SIZE_STD_Y = 0.04f;
const float _SIZE_STD_Z = 0.04f;

const float _SIZE_MEAN_MALE = 1.0f;
const float _SIZE_MEAN_FEMALE = 0.925f;

const string VAR_RANDOMIZE_NPC = "00_RANDOMIZE_NPC";
const string VAR_RANDOMIZE_NPC_EQUIP = "00_RANDOMIZE_NPC_EQUIP";
const string VAR_RANDOMIZE_NPC_NAME = "00_RANDOMIZE_NPC_NAME";


void RandomizeNPCName(object oNPC = OBJECT_SELF)
{
	string s0="",s1="";
	int gender = GetGender(oNPC);

	switch (GetRacialType(oNPC)) {
		case RACIAL_TYPE_DWARF:
			s0 = RandomNameDwarf(gender);
			break;
		case RACIAL_TYPE_GNOME:
			s0 = RandomNameGnome(gender);
			if (!Random(4))
				s1 = RandomNameGnome(gender,1);
			break;
		case RACIAL_TYPE_ELF:
			switch ( GetSubRace( oNPC ) ) {
				case RACIAL_SUBTYPE_DROW:
					s0 = RandomNameDrow(gender);
					break;
				default:
					s0 = RandomNameElf(gender);
					s1 = RandomNameElf(0);
			}
			break;
		default:
			s0 = RandomNameHuman(gender);
			s1 = RandomNameHuman(0);
	}

	s1 += "{Random}";

	SetFirstName(oNPC, s0);
	SetLastName(oNPC, s1);
}

void RandomizeNPCAppearance(object oNPC = OBJECT_SELF)
{
	// Racial overrides.
	float fFacialHairChance = 0.5;
	int nHair1Color = ACR_FEATURE_TYPE_RANDOM;
	int nHair2Color = ACR_FEATURE_TYPE_RANDOM;
	switch( GetSubRace( oNPC ) ) {
		case RACIAL_SUBTYPE_GOLD_DWARF:
		case RACIAL_SUBTYPE_GRAY_DWARF:
		case RACIAL_SUBTYPE_SHIELD_DWARF:
			// Dwarves have a higher beard chance.
			fFacialHairChance = 0.8;
			break;
		case RACIAL_SUBTYPE_DROW:
			// Drow only have white hair.
			nHair1Color = 1;
			nHair2Color = 0;
		case RACIAL_SUBTYPE_MOON_ELF:
		case RACIAL_SUBTYPE_SUN_ELF:
		case RACIAL_SUBTYPE_WILD_ELF:
		case RACIAL_SUBTYPE_WOOD_ELF:
			// Elves don't get beards.
			fFacialHairChance = 0.0;
			break;
			
	}

	ACR_RandomizeAppearance( oNPC, ACR_FEATURE_TYPE_RANDOM, ACR_FEATURE_TYPE_RANDOM, nHair1Color, nHair2Color, ACR_FEATURE_TYPE_RANDOM, ACR_FEATURE_TYPE_RANDOM, ACR_FEATURE_TYPE_RANDOM, ACR_FEATURE_TYPE_RANDOM, fFacialHairChance );
}

void RandomizeNPCScale(object oNPC = OBJECT_SELF, int autoscale = 1, float std_x = _SIZE_STD_X, float std_y = _SIZE_STD_Y, float std_z = _SIZE_STD_Z)
{
	vector scale;

	scale.x = ACR_RandomNormal(_SIZE_MEAN_MALE, std_x);
	scale.y = ACR_RandomNormal(_SIZE_MEAN_MALE, std_y);
	scale.z = ACR_RandomNormal(_SIZE_MEAN_MALE, std_z);

	if (autoscale) {
		// scale smaller for female
		if (GetGender(oNPC) == GENDER_FEMALE) {
			scale.x *= _SIZE_MEAN_FEMALE;
			scale.y *= _SIZE_MEAN_FEMALE;
			scale.z *= _SIZE_MEAN_FEMALE;
		}
	}
	else {
		scale.x *= GetScale(oNPC, SCALE_X);
		scale.y *= GetScale(oNPC, SCALE_Y);
		scale.z *= GetScale(oNPC, SCALE_Z);
	}

	SetScale(oNPC,scale.x,scale.y,scale.z);
}


void RandomNPCEquip(object oArmour, object oBoots)
{
	if ((GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF) == oArmour) &&
		(GetItemInSlot(INVENTORY_SLOT_BOOTS, OBJECT_SELF) == oBoots))
		return;

	ClearAllActions(TRUE);

	DelayCommand(9.0, RandomNPCEquip(oArmour, oBoots));

	ActionEquipItem(oArmour,1);
	ActionEquipItem(oBoots,2);
}

void RandomizeNPCClothing(object oNPC = OBJECT_SELF)
{
	string sArmType,sBootType;
	int rCloth,rBoots,gender=GetGender(oNPC);

	
	///RANDOM EQUIP/////
	rCloth=Random(20)+1;
	rBoots=Random(10)+1;
	
	//create clothing
	switch (rCloth)//updated to tsm BPs
		{
		case 1:sArmType="03_it_arm_l_bl_012";break;
		case 2:sArmType="03_it_arm_l_bl_033";break;
		case 3:sArmType="03_it_arm_l_bl_223";break;
		case 4:sArmType="03_it_arm_l_ye_171";break;
		case 5:sArmType="03_it_arm_l_re_201";break;
		case 6:sArmType="03_it_arm_l_gr_091";break;
		case 7:sArmType="010_it_clothcomb";break;
		case 8:sArmType="010_it_clothcom0";break;
		case 9:sArmType="010_it_clothcomc2";break;
		case 10:sArmType="003_it_arm_tunic_peasant";break;
		case 11:sArmType="03_it_arm_l_gr_141";break;
		case 12:sArmType="03_it_arm_l_wh_131";break;
		case 13:sArmType="010_it_t_cloth03";break;
		case 14:sArmType="010_it_t_cloth02";break;
		case 15:sArmType="03_it_arm_l_bl_052";break;
		case 16:sArmType="03_it_arm_l_gr_121";break;
		case 17:sArmType="aca_it_ar_cloth02";break;
		case 18:sArmType="aca_it_ar_cloth05";break;
		case 19:sArmType="03_it_arm_l_re_52";break;
		case 20:sArmType="09_it_cloth_f_dress_layered";break;
		}
	object oArmour=CreateItemOnObject(sArmType);
	//create boots
	switch (rBoots)//updated to TSM BPs
		{
		case 1:sBootType="10_it_boo_bl_l_130";break;
		case 2:sBootType="aca_it_bts_plain01";break;
		case 3:sBootType="03_it_boo_br_l_12000";break;
		case 4:sBootType="03_it_boo_br_l_03000";break;
		case 5:sBootType="03_it_boo_ye_l_050000";break;
		case 6:sBootType="03_it_boo_wh_l_110000";break;
		case 7:sBootType="03_it_boo_wh_l_020000";break;
		case 8:sBootType="010_it_bootscloth3";break;
		case 9:sBootType="03_it_boo_bl_l_04000";break;
		case 10:sBootType="03_it_boo_bl_l_02000";break;
		}
	object oBoots=CreateItemOnObject(sBootType);

	RandomNPCEquip(oArmour, oBoots);
}

void RandomizeNPC(object oNPC = OBJECT_SELF, int nEquip=1, int nName=1)
{
	RandomizeNPCAppearance(oNPC);
	RandomizeNPCScale(oNPC);

/*
	// pick a randomly distributed heartbeat
	SetCustomHeartbeat(OBJECT_SELF, FloatToInt(1000.0*ACR_RandomNormal(6.0,1.0)));
*/

	if (nName)
		RandomizeNPCName(oNPC);

	if (nEquip)
		RandomizeNPCClothing(oNPC);
}

string RandomNPCResref(int race=RACIAL_TYPE_HUMAN, float prob = 0.2)
{
	string sResRef="";

	if (ACR_RandomFloat() < prob)
		return "";

	switch (race) {
		case RACIAL_TYPE_DWARF:
			switch (Random(4)) {
				case 0:
					sResRef="03_tsm_commoner_sdw_f";
					break;
				case 1:
					sResRef="03_tsm_commoner_gdw_f";
					break;
				case 2:
					sResRef="03_tsm_commoner_sdw_m";
					break;
				case 3:
					sResRef="03_tsm_commoner_gdw_m";
					break;
			}
			break;
			
		case RACIAL_TYPE_ELF:  
			switch (Random(4)) {
				case 0:
					sResRef="03_tsm_commoner_melf_f";
					break;
				case 1:
					sResRef="03_tsm_commoner_self_f";
					break;
				case 2:
					sResRef="03_tsm_commoner_melf_m";
					break;
				case 3:
					sResRef="03_tsm_commoner_self_m";
					break;
			}
			break;
			
		case RACIAL_TYPE_GNOME:
			switch (Random(2)) {
				case 0:
					sResRef="03_tsm_commoner_gn_m";
					break;
				case 1:
					sResRef="03_tsm_commoner_gn_f";
					break;
				}
			break;
			
		case RACIAL_TYPE_HALFLING:  
			switch (Random(4)) {
				case 0:
					sResRef="03_tsm_commoner_shalf_f";
					break;
				case 1:
					sResRef="03_tsm_commoner_lhalf_f";
					break;
				case 2:
					sResRef="03_tsm_commoner_shalf_m";
					break;
				case 3:
					sResRef="03_tsm_commoner_lhalf_m";
					break;
			}
			break;
				
		case RACIAL_TYPE_HALFORC:
			switch(Random(4)) {
				case 0:
					sResRef = "03_tsm_commoner_horc_m";
					break;
				case 1:
					sResRef = "03_tsm_commoner_horc_f";
					break;
			}
			break;
			
		case RACIAL_TYPE_HUMAN:  
		default:
			switch (Random(2)) {
				case 0:
					sResRef="03_tsm_commoner_hum_m";
					break;
				case 1:
					sResRef="03_tsm_commoner_hum_f";
					break;
				
		}
		break;
		
	}
	return sResRef;
}

void RandomizeNPC_OnSpawnIn( object oSpawn ) {
	// First check to see if we are calling the random NPC system.
	if ( GetLocalInt( oSpawn, VAR_RANDOMIZE_NPC ) ) {
		RandomizeNPC( oSpawn, GetLocalInt( oSpawn, VAR_RANDOMIZE_NPC_EQUIP ), GetLocalInt( oSpawn, VAR_RANDOMIZE_NPC_NAME ) );
	}
}