
string generate_dwarf_name(int female)
{
	string str = "";
	switch (Random(20)) {
		case 0:
			str += "B";
			break;
		case 1:
			str += "Bal";
			break;
		case 2:
			str += "Bel";
			break;
		case 3:
			str += "Bof";
			break;
		case 4:
			str += "Bol";
			break;
		case 5:
			str += "D";
			break;
		case 6:
			str += "Dal";
			break;
		case 7:
			str += "Dor";
			break;
		case 8:
			str += "Dw";
			break;
		case 9:
			str += "Far";
			break;
		case 10:
			str += "Gil";
			break;
		case 11:
			str += "Gim";
			break;
		case 12:
			str += "Kil";
			break;
		case 13:
			str += "Mor";
			break;
		case 14:
			str += "Nal";
			break;
		case 15:
			str += "Nor";
			break;
		case 16:
			str += "Ov";
			break;
		case 17:
			str += "Th";
			break;
		case 18:
			str += "Thor";
			break;
		case 19:
			str += "Thr";
			break;
	}

	switch (Random(16)) {
		case 0:
			str += "b";
			break;
		case 1:
			str += "d";
			break;
		case 2:
			str += "f";
			break;
		case 3:
			str += "g";
			break;
		case 4:
			str += "k";
			break;
		case 5:
			str += "m";
			break;
		case 6:
			str += "t";
			break;
		case 7:
			str += "v";
			break;
		case 8:
			str += "z";
			break;
		case 9:
			str += "";
			break;
		case 10:
			str += "";
			break;
		case 11:
			str += "";
			break;
		case 12:
			str += "";
			break;
		case 13:
			str += "";
			break;
		case 14:
			str += "";
			break;
		case 15:
			str += "";
			break;
	}

	if (female) {
		switch (Random(10)) {
			case 0:
				str +=  "a";
				break;
			case 1:
				str +=  "ala";
				break;
			case 2:
				str +=  "ana";
				break;
			case 3:
				str +=  "ip";
				break;
			case 4:
				str +=  "ia";
				break;
			case 5:
				str +=  "ila";
				break;
			case 6:
				str +=  "ina";
				break;
			case 7:
				str +=  "on";
				break;
			case 8:
				str +=  "ola";
				break;
			case 9:
				str +=  "ona";
				break;
		}
	}
	else {
		switch (Random(10)) {
			case 0:
				str +=  "aim";
				break;
			case 1:
				str +=  "ain";
				break;
			case 2:
				str +=  "ak";
				break;
			case 3:
				str +=  "ar";
				break;
			case 4:
				str +=  "i";
				break;
			case 5:
				str +=  "im";
				break;
			case 6:
				str +=  "in";
				break;
			case 7:
				str +=  "o";
				break;
			case 8:
				str +=  "or";
				break;
			case 9:
				str +=  "ur";
				break;
		}
	}

	return str;
}

string generate_gnome_name(int female,int last)
{
	string str = "";
	int i;

	if (!last) {
		for (i=0; i<=Random(3); ++i) {
		
			switch (Random(40)) {
				case 0:
					str += "Arum";
					break;
				case 1:
					str += "Add";
					break;
				case 2:
					str += "Baer";
					break;
				case 3:
					str += "Bar";
					break;
				case 4:
					str += "Callad";
					break;
				case 5:
					str += "Chik";
					break;
				case 6:
					str += "Dal";
					break;
				case 7:
					str += "Din";
					break;
				case 8:
					str += "Eaus";
					break;
				case 9:
					str += "Erf";
					break;
				case 10:
					str += "Enn";
					break;
				case 11:
					str += "Faer";
					break;
				case 12:
					str += "Flan";
					break;
				case 13:
					str += "Fen";
					break;
				case 14:
					str += "Gaer";
					break;
				case 15:
					str += "Gar";
					break;
				case 16:
					str += "Hed";
					break;
				case 17:
					str += "Herl";
					break;
				case 18:
					str += "Ien";
					break;
				case 19:
					str += "Jan";
					break;
				case 20:
					str += "Kaer";
					break;
				case 21:
					str += "Len";
					break;
				case 22:
					str += "Lun";
					break;
				case 23:
					str += "Mikk";
					break;
				case 24:
					str += "Neb";
					break;
				case 25:
					str += "Oaen";
					break;
				case 26:
					str += "Ow";
					break;
				case 27:
					str += "Pall";
					break;
				case 28:
					str += "Pin";
					break;
				case 29:
					str += "Raer";
					break;
				case 30:
					str += "Ras";
					break;
				case 31:
					str += "Seg";
					break;
				case 32:
					str += "Skor";
					break;
				case 33:
					str += "Tikk";
					break;
				case 34:
					str += "Uran";
					break;
				case 35:
					str += "Urd";
					break;
				case 36:
					str += "Van";
					break;
				case 37:
					str += "Var";
					break;
				case 38:
					str += "Wann";
					break;
				case 39:
					str += "Wed";
					break;
			}
		}
	}
	else {
		switch (Random(20)) {
			case 0:
				str += "Wild";
				break;
			case 1:
				str += "Earth";
				break;
			case 2:
				str += "Fast";
				break;
			case 3:
				str += "Fast";
				break;
			case 4:
				str += "Glitter";
				break;
			case 5:
				str += "Gold";
				break;
			case 6:
				str += "Honor";
				break;
			case 7:
				str += "Iron";
				break;
			case 8:
				str += "Lightning";
				break;
			case 9:
				str += "Moon";
				break;
			case 10:
				str += "Shadow";
				break;
			case 11:
				str += "Shadow";
				break;
			case 12:
				str += "Silver";
				break;
			case 13:
				str += "Sly";
				break;
			case 14:
				str += "Sly";
				break;
			case 15:
				str += "Small";
				break;
			case 16:
				str += "Steel";
				break;
			case 17:
				str += "Stone";
				break;
			case 18:
				str += "Sun";
				break;
			case 19:
				str += "Swift";
				break;
		}
	
		switch (Random(20)) {
			case 0:
				str += "Bones";
				break;
			case 1:
				str += "Caller";
				break;
			case 2:
				str += "Caller";
				break;
			case 3:
				str += "Cloak";
				break;
			case 4:
				str += "Eye";
				break;
			case 5:
				str += "Foot";
				break;
			case 6:
				str += "Fox";
				break;
			case 7:
				str += "Gold";
				break;
			case 8:
				str += "Hand";
				break;
			case 9:
				str += "Hand";
				break;
			case 10:
				str += "Flower";
				break;
			case 11:
				str += "Heart";
				break;
			case 12:
				str += "Leaf";
				break;
			case 13:
				str += (female ? "Lady" : "Man");
				break;
			case 14:
				str += "Skin";
				break;
			case 15:
				str += "Strider";
				break;
			case 16:
				str += "Wanderer";
				break;
			case 17:
				str += "Wanderer";
				break;
			case 18:
				str += "Will";
				break;
			case 19:
				str += "Whisper";
				break;
		}
	}
	
	str = (GetStringUpperCase(GetSubString(str,0,1)) + GetStringLowerCase(GetSubString(str,1,GetStringLength(str))));
	return str;
}

string generate_human_name(int female)
{
	string str = RandomName();

	if (female) {
		switch (Random(6)) {
			case 0:
				str += "a";
				break;
			case 1:
				str += "ie";
				break;
			case 2:
				str += "re";
				break;
			case 3:
				str += "ele";
				break;
			case 4:
				str += "na";
				break;
			case 5:
				str += "ni";
				break;
		}	
	}
	return str;
}

string RandomNameDwarf(int nFemale=0)
{
	return generate_dwarf_name(nFemale);
}

string RandomNameGnome(int nFemale=0,int nLast=0)
{
	return generate_gnome_name(nFemale,nLast);
}

string RandomNameHuman(int nFemale=0)
{
	return generate_human_name(nFemale);
}

string RandomNameDrowPrefix( int nGender ) {
	switch ( Random(100) ) {
		case 1: return ( ( nGender == GENDER_FEMALE ) ? "akor" : "alak" );
		case 2: return ( ( nGender == GENDER_FEMALE ) ? "alaun" : "alton" );
		case 3: return ( ( nGender == GENDER_FEMALE ) ? "aly" : "kel" );
		case 4: return ( ( nGender == GENDER_FEMALE ) ? "ang" : "adin" );
		case 5: return ( ( nGender == GENDER_FEMALE ) ? "ardul" : "amal" );
		case 6: return ( ( nGender == GENDER_FEMALE ) ? "aun" : "ant" );
		case 7: return ( ( nGender == GENDER_FEMALE ) ? "bae" : "bar" );
		case 8: return ( ( nGender == GENDER_FEMALE ) ? "bal" : "bel" );
		case 9: return ( ( nGender == GENDER_FEMALE ) ? "belar" : "bruh" );
		case 10: return ( ( nGender == GENDER_FEMALE ) ? "briz" : "berg" );
		case 11: return ( ( nGender == GENDER_FEMALE ) ? "bur" : "bhin" );
		case 12: return ( ( nGender == GENDER_FEMALE ) ? "chal" : "chasz" );
		case 13: return ( ( nGender == GENDER_FEMALE ) ? "char" : "kron" );
		case 14: return ( ( nGender == GENDER_FEMALE ) ? "chess" : "cal" );
		case 15: return "dhaun";
		case 16: return ( ( nGender == GENDER_FEMALE ) ? "dil" : "dur" );
		case 17: return ( ( nGender == GENDER_FEMALE ) ? "dirz" : "div" );
		case 18: return ( ( nGender == GENDER_FEMALE ) ? "dris" : "riz" );
		case 19: return ( ( nGender == GENDER_FEMALE ) ? "eclave" : "elk" );
		case 20: return ( ( nGender == GENDER_FEMALE ) ? "elvan" : "kalan" );
		case 21: return ( ( nGender == GENDER_FEMALE ) ? "elv" : "elaug" );
		case 22: return ( ( nGender == GENDER_FEMALE ) ? "erel" : "rhyl" );
		case 23: return ( ( nGender == GENDER_FEMALE ) ? "ethe" : "erth" );
		case 24: return ( ( nGender == GENDER_FEMALE ) ? "faer" : "selds" );
		case 25: return ( ( nGender == GENDER_FEMALE ) ? "felyn" : "fil" );
		case 26: return ( ( nGender == GENDER_FEMALE ) ? "filf" : "phar" );
		case 27: return ( ( nGender == GENDER_FEMALE ) ? "gauss" : "orgoll" );
		case 28: return "g'eld";
		case 29: return "ghaun";
		case 30: return ( ( nGender == GENDER_FEMALE ) ? "gin" : "din" );
		case 31: return ( ( nGender == GENDER_FEMALE ) ? "grey" : "gul" );
		case 32: return ( ( nGender == GENDER_FEMALE ) ? "hael" : "hatch" );
		case 33: return ( ( nGender == GENDER_FEMALE ) ? "hal" : "sol" );
		case 34: return ( ( nGender == GENDER_FEMALE ) ? "houn" : "rik" );
		case 35: return ( ( nGender == GENDER_FEMALE ) ? "iliv" : "dip" );
		case 36: return "ilm";
		case 37: return ( ( nGender == GENDER_FEMALE ) ? "illiam" : "im" );
		case 38: return ( ( nGender == GENDER_FEMALE ) ? "in" : "sorn" );
		case 39: return "ilph";
		case 40: return ( ( nGender == GENDER_FEMALE ) ? "irae" : "ilzt" );
		case 41: return ( ( nGender == GENDER_FEMALE ) ? "irr" : "izz" );
		case 42: return ( ( nGender == GENDER_FEMALE ) ? "iym" : "ist" );
		case 43: return ( ( nGender == GENDER_FEMALE ) ? "jhan" : "duag" );
		case 44: return ( ( nGender == GENDER_FEMALE ) ? "jhael" : "gel" );
		case 45: return ( ( nGender == GENDER_FEMALE ) ? "jhul" : "jar" );
		case 46: return ( ( nGender == GENDER_FEMALE ) ? "jys" : "driz" );
		case 47: return ( ( nGender == GENDER_FEMALE ) ? "lael" : "llt" );
		case 48: return ( ( nGender == GENDER_FEMALE ) ? "lar" : "les" );
		case 49: return ( ( nGender == GENDER_FEMALE ) ? "lineeer" : "mourn" );
		case 50: return ( ( nGender == GENDER_FEMALE ) ? "lird" : "ryld" );
		case 51: return ( ( nGender == GENDER_FEMALE ) ? "lua" : "lyme" );
		case 52: return ( ( nGender == GENDER_FEMALE ) ? "mal" : "malag" );
		case 53: return ( ( nGender == GENDER_FEMALE ) ? "may" : "mas" );
		case 54: return "micar";
		case 55: return ( ( nGender == GENDER_FEMALE ) ? "min" : "ran" );
		case 56: return ( ( nGender == GENDER_FEMALE ) ? "mol" : "go" );
		case 57: return ( ( nGender == GENDER_FEMALE ) ? "myr" : "nym" );
		case 58: return ( ( nGender == GENDER_FEMALE ) ? "nath" : "mer" );
		case 59: return ( ( nGender == GENDER_FEMALE ) ? "ned" : "nad" );
		case 60: return ( ( nGender == GENDER_FEMALE ) ? "nhil" : "nal" );
		case 61: return "neer";
		case 62: return ( ( nGender == GENDER_FEMALE ) ? "null" : "nil" );
		case 63: return ( ( nGender == GENDER_FEMALE ) ? "olor" : "omar" );
		case 64: return ( ( nGender == GENDER_FEMALE ) ? "pellan" : "relon" );
		case 65: return ( ( nGender == GENDER_FEMALE ) ? "phaer" : "vorn" );
		case 66: return ( ( nGender == GENDER_FEMALE ) ? "phyr" : "phyx" );
		case 67: return ( ( nGender == GENDER_FEMALE ) ? "qualn" : "quil" );
		case 68: return "quar";
		case 69: return ( ( nGender == GENDER_FEMALE ) ? "quav" : "quev" );
		case 70: return ( ( nGender == GENDER_FEMALE ) ? "qil" : "quil" );
		case 71: return ( ( nGender == GENDER_FEMALE ) ? "rauv" : "welv" );
		case 72: return ( ( nGender == GENDER_FEMALE ) ? "ril" : "ryl" );
		case 73: return ( ( nGender == GENDER_FEMALE ) ? "sabal" : "szor" );
		case 74: return ( ( nGender == GENDER_FEMALE ) ? "sab" : "tsab" );
		case 75: return ( ( nGender == GENDER_FEMALE ) ? "shi'n" : "kren" );
		case 76: return ( ( nGender == GENDER_FEMALE ) ? "shri" : "ssz" );
		case 77: return ( ( nGender == GENDER_FEMALE ) ? "shur" : "shar" );
		case 78: return "shynt";
		case 79: return ( ( nGender == GENDER_FEMALE ) ? "sin" : "szin" );
		case 80: return ( ( nGender == GENDER_FEMALE ) ? "ssap" : "that" );
		case 81: return ( ( nGender == GENDER_FEMALE ) ? "susp" : "spir" );
		case 82: return ( ( nGender == GENDER_FEMALE ) ? "talab" : "tluth" );
		case 83: return ( ( nGender == GENDER_FEMALE ) ? "tal" : "tar" );
		case 84: return ( ( nGender == GENDER_FEMALE ) ? "triel" : "taz" );
		case 85: return ( ( nGender == GENDER_FEMALE ) ? "t'riss" : "teb" );
		case 86: return ( ( nGender == GENDER_FEMALE ) ? "ulviir" : "uhls" );
		case 87: return ( ( nGender == GENDER_FEMALE ) ? "umrae" : "hurz" );
		case 88: return ( ( nGender == GENDER_FEMALE ) ? "vas" : "vesz" );
		case 89: return "vic";
		case 90: return ( ( nGender == GENDER_FEMALE ) ? "vier" : "val" );
		case 91: return ( ( nGender == GENDER_FEMALE ) ? "vlon" : "wod" );
		case 92: return ( ( nGender == GENDER_FEMALE ) ? "waer" : "wehl" );
		case 93: return ( ( nGender == GENDER_FEMALE ) ? "wuyon" : "wruz" );
		case 94: return ( ( nGender == GENDER_FEMALE ) ? "xull" : "url" );
		case 95: return "xun";
		case 96: return ( ( nGender == GENDER_FEMALE ) ? "yas" : "yaz" );
		case 97: return ( ( nGender == GENDER_FEMALE ) ? "zar" : "zakn" );
		case 98: return ( ( nGender == GENDER_FEMALE ) ? "zebey" : "zek" );
		case 99: return ( ( nGender == GENDER_FEMALE ) ? "zes" : "zez" );
		default: return ( ( nGender == GENDER_FEMALE ) ? "zilv" : "vuz" );
	}
	return "";
}

string RandomNameDrowSuffix( int nGender ) {
	switch ( Random(100) ) {
		case 1: return ( ( nGender == GENDER_FEMALE ) ? "a" : "agh" );
		case 2: return ( ( nGender == GENDER_FEMALE ) ? "ace" : "as" );
		case 3: return ( ( nGender == GENDER_FEMALE ) ? "ae" : "aun" );
		case 4: return ( ( nGender == GENDER_FEMALE ) ? "aere" : "d" );
		case 5: return ( ( nGender == GENDER_FEMALE ) ? "afae" : "afein" );
		case 6: return ( ( nGender == GENDER_FEMALE ) ? "afay" : "aufein" );
		case 7: return ( ( nGender == GENDER_FEMALE ) ? "ala" : "launim" );
		case 8: return ( ( nGender == GENDER_FEMALE ) ? "anna" : "erin" );
		case 9: return ( ( nGender == GENDER_FEMALE ) ? "arra" : "atar" );
		case 10: return "aste";
		case 11: return ( ( nGender == GENDER_FEMALE ) ? "avin" : "aonar" );
		case 12: return ( ( nGender == GENDER_FEMALE ) ? "ayne" : "al" );
		case 13: return ( ( nGender == GENDER_FEMALE ) ? "baste" : "gloth" );
		case 14: return ( ( nGender == GENDER_FEMALE ) ? "breena" : "antar" );
		case 15: return ( ( nGender == GENDER_FEMALE ) ? "bryn" : "lyn" );
		case 16: return ( ( nGender == GENDER_FEMALE ) ? "cice" : "roos" );
		case 17: return ( ( nGender == GENDER_FEMALE ) ? "cyrl" : "axle" );
		case 18: return ( ( nGender == GENDER_FEMALE ) ? "da" : "daer" );
		case 19: return ( ( nGender == GENDER_FEMALE ) ? "dia" : "drin" );
		case 20: return ( ( nGender == GENDER_FEMALE ) ? "diira" : "diirn" );
		case 21: return ( ( nGender == GENDER_FEMALE ) ? "dra" : "zar" );
		case 22: return ( ( nGender == GENDER_FEMALE ) ? "driira" : "driirn" );
		case 23: return ( ( nGender == GENDER_FEMALE ) ? "dril" : "dorl" );
		case 24: return "e";
		case 25: return ( ( nGender == GENDER_FEMALE ) ? "eari" : "erd" );
		case 26: return "eyl";
		case 27: return ( ( nGender == GENDER_FEMALE ) ? "ffyn" : "fein" );
		case 28: return "fryn";
		case 29: return ( ( nGender == GENDER_FEMALE ) ? "iara" : "ica" );
		case 30: return ( ( nGender == GENDER_FEMALE ) ? "ice" : "eth" );
		case 31: return ( ( nGender == GENDER_FEMALE ) ? "idil" : "imar" );
		case 32: return ( ( nGender == GENDER_FEMALE ) ? "iira" : "inid" );
		case 33: return "inidia";
		case 34: return ( ( nGender == GENDER_FEMALE ) ? "inil" : "in" );
		case 35: return "intra";
		case 36: return ( ( nGender == GENDER_FEMALE ) ? "isstra" : "atlab" );
		case 37: return ( ( nGender == GENDER_FEMALE ) ? "ithra" : "irahc" );
		case 38: return ( ( nGender == GENDER_FEMALE ) ? "jra" : "gos" );
		case 39: return "jss";
		case 40: return ( ( nGender == GENDER_FEMALE ) ? "kacha" : "kah" );
		case 41: return ( ( nGender == GENDER_FEMALE ) ? "kiira" : "raen" );
		case 42: return ( ( nGender == GENDER_FEMALE ) ? "lay" : "dyn" );
		case 43: return ( ( nGender == GENDER_FEMALE ) ? "lara" : "aghar" );
		case 44: return "lin";
		case 45: return "lochar";
		case 46: return ( ( nGender == GENDER_FEMALE ) ? "mice" : "myr" );
		case 47: return "mur'ss";
		case 48: return ( ( nGender == GENDER_FEMALE ) ? "na" : "nar" );
		case 49: return ( ( nGender == GENDER_FEMALE ) ? "nilee" : "olil" );
		case 50: return ( ( nGender == GENDER_FEMALE ) ? "niss" : "nozz" );
		case 51: return ( ( nGender == GENDER_FEMALE ) ? "nitra" : "net" );
		case 52: return "nolu";
		case 53: return "olin";
		case 54: return ( ( nGender == GENDER_FEMALE ) ? "onia" : "onim" );
		case 55: return ( ( nGender == GENDER_FEMALE ) ? "oyss" : "omph" );
		case 56: return "qualyn";
		case 57: return ( ( nGender == GENDER_FEMALE ) ? "quarra" : "net" );
		case 58: return ( ( nGender == GENDER_FEMALE ) ? "quiri" : "oj" );
		case 59: return ( ( nGender == GENDER_FEMALE ) ? "ra" : "or" );
		case 60: return ( ( nGender == GENDER_FEMALE ) ? "rae" : "rar" );
		case 61: return ( ( nGender == GENDER_FEMALE ) ? "raema" : "orvir" );
		case 62: return ( ( nGender == GENDER_FEMALE ) ? "raena" : "olvir" );
		case 63: return ( ( nGender == GENDER_FEMALE ) ? "riia" : "rak" );
		case 64: return "ril";
		case 65: return ( ( nGender == GENDER_FEMALE ) ? "riina" : "ree" );
		case 66: return ( ( nGender == GENDER_FEMALE ) ? "ryna" : "oyn" );
		case 67: return ( ( nGender == GENDER_FEMALE ) ? "ryne" : "ryn" );
		case 68: return ( ( nGender == GENDER_FEMALE ) ? "shalee" : "ral" );
		case 69: return ( ( nGender == GENDER_FEMALE ) ? "ssysn" : "rysn" );
		case 70: return ( ( nGender == GENDER_FEMALE ) ? "stin" : "trin" );
		case 71: return ( ( nGender == GENDER_FEMALE ) ? "stra" : "tran" );
		case 72: return ( ( nGender == GENDER_FEMALE ) ? "tana" : "ton" );
		case 73: return ( ( nGender == GENDER_FEMALE ) ? "thara" : "tar" );
		case 74: return ( ( nGender == GENDER_FEMALE ) ? "thrae" : "olg" );
		case 75: return ( ( nGender == GENDER_FEMALE ) ? "tree" : "tel" );
		case 76: return "tyrr";
		case 77: return ( ( nGender == GENDER_FEMALE ) ? "ual" : "dan" );
		case 78: return ( ( nGender == GENDER_FEMALE ) ? "ue" : "dor" );
		case 79: return ( ( nGender == GENDER_FEMALE ) ? "uit" : "dar" );
		case 80: return ( ( nGender == GENDER_FEMALE ) ? "une" : "dinn" );
		case 81: return "uque";
		case 82: return ( ( nGender == GENDER_FEMALE ) ? "urra" : "dax" );
		case 83: return ( ( nGender == GENDER_FEMALE ) ? "va" : "ven" );
		case 84: return "vayas";
		case 85: return "vyll";
		case 86: return ( ( nGender == GENDER_FEMALE ) ? "vrae" : "vyr" );
		case 87: return ( ( nGender == GENDER_FEMALE ) ? "wae" : "hrae" );
		case 88: return ( ( nGender == GENDER_FEMALE ) ? "wiira" : "hriir" );
		case 89: return ( ( nGender == GENDER_FEMALE ) ? "wyss" : "hrys" );
		case 90: return ( ( nGender == GENDER_FEMALE ) ? "xae" : "zaer" );
		case 91: return ( ( nGender == GENDER_FEMALE ) ? "xena" : "zen" );
		case 92: return ( ( nGender == GENDER_FEMALE ) ? "xyra" : "zyr" );
		case 93: return "yl";
		case 94: return ( ( nGender == GENDER_FEMALE ) ? "ylene" : "yln" );
		case 95: return ( ( nGender == GENDER_FEMALE ) ? "ymma" : "inyon" );
		case 96: return ( ( nGender == GENDER_FEMALE ) ? "ynda" : "yrd" );
		case 97: return ( ( nGender == GENDER_FEMALE ) ? "ynrae" : "yraen" );
		case 98: return "vrae";
		case 99: return "yrr";
		default: return ( ( nGender == GENDER_FEMALE ) ? "zyne" : "zt" );
	}
	return "";
}

string RandomNameDrow( int nGender ) {
	// They see me rollin'
	int rRoll = d10();
	string sName = "";
	if ( rRoll <= 5 ) {
		sName = RandomNameDrowPrefix( nGender ) + RandomNameDrowSuffix( nGender );
	} else if ( rRoll <= 8 ) {
		sName = RandomNameDrowPrefix( nGender ) + RandomNameDrowSuffix( nGender ) + RandomNameDrowSuffix( nGender );
	} else if ( rRoll <= 9 ) {
		sName = RandomNameDrowPrefix( nGender ) + RandomNameDrowSuffix( nGender ) + "'" + RandomNameDrowSuffix( nGender );
	} else {
		sName = RandomNameDrowSuffix( nGender ) + "'" + RandomNameDrowPrefix( nGender ) + RandomNameDrowSuffix( nGender );
	}
	
	// They hatin'
	return GetStringUpperCase( GetSubString( sName, 1, 1 ) ) + GetSubString( sName, 2, GetStringLength( sName ) - 1 );
}

string RandomNameElfPrefix( int nGender ) {
	switch ( Random(100) ) {
		case 1: return "ael";
		case 2: return "aer";
		case 3: return "af";
		case 4: return "ah";
		case 5: return "al";
		case 6: return "am";
		case 7: return "ama";
		case 8: return "an";
		case 9: return "ang";
		case 10: return "ansr";
		case 11: return "ar";
		case 12: return "ari";
		case 13: return "arn";
		case 14: return "aza";
		case 15: return "bael";
		case 16: return "bes";
		case 17: return "cael";
		case 18: return "cal";
		case 19: return "cas";
		case 20: return "cla";
		case 21: return "cor";
		case 22: return "cy";
		case 23: return "dae";
		case 24: return "dho";
		case 25: return "dre";
		case 26: return "du";
		case 27: return "eil";
		case 28: return "eir";
		case 29: return "el";
		case 30: return "er";
		case 31: return "ev";
		case 32: return "fera";
		case 33: return "fi";
		case 34: return "fir";
		case 35: return "fis";
		case 36: return "gael";
		case 37: return "gar";
		case 38: return "gil";
		case 39: return "ha";
		case 40: return "hu";
		case 41: return "ia";
		case 42: return "il";
		case 43: return "ja";
		case 44: return "jar";
		case 45: return "ka";
		case 46: return "kan";
		case 47: return "ker";
		case 48: return "keth";
		case 49: return "koeh";
		case 50: return "kor";
		case 51: return "ky";
		case 52: return "la";
		case 53: return "laf";
		case 54: return "lam";
		case 55: return "lue";
		case 56: return "ly";
		case 57: return "mai";
		case 58: return "mal";
		case 59: return "mara";
		case 60: return "my";
		case 61: return "na";
		case 62: return "nai";
		case 63: return "nim";
		case 64: return "nu";
		case 65: return "ny";
		case 66: return "py";
		case 67: return "raer";
		case 68: return "re";
		case 69: return "ren";
		case 70: return ( ( nGender == GENDER_FEMALE ) ? "rhy" : "ry" );
		case 71: return "ru";
		case 72: return "rua";
		case 73: return "rum";
		case 74: return "rid";
		case 75: return "sai";
		case 76: return "seh";
		case 77: return "sel";
		case 78: return "sha";
		case 79: return "she";
		case 80: return "si";
		case 81: return "sim";
		case 82: return "sol";
		case 83: return "sum";
		case 84: return "syl";
		case 85: return "ta";
		case 86: return "tahl";
		case 87: return "tha";
		case 88: return "tho";
		case 89: return "ther";
		case 90: return "thro";
		case 91: return "tia";
		case 92: return "tra";
		case 93: return ( ( nGender == GENDER_FEMALE ) ? "ty" : "try" );
		case 94: return "uth";
		case 95: return "ver";
		case 96: return "vil";
		case 97: return "von";
		case 98: return "ya";
		case 99: return "za";
		default: return "zy";
	}
	return "";
}

string RandomNameElfSuffix( int nGender ) {
	switch ( Random(100) ) {
		case 1: return ( ( nGender == GENDER_FEMALE ) ? "ae" : "nae" );
		case 2: return "ael";
		case 3: return ( ( nGender == GENDER_FEMALE ) ? "aer" : "aera" );
		case 4: return ( ( nGender == GENDER_FEMALE ) ? "aias" : "aia" );
		case 5: return ( ( nGender == GENDER_FEMALE ) ? "ah" : "aha" );
		case 6: return ( ( nGender == GENDER_FEMALE ) ? "aith" : "aira" );
		case 7: return ( ( nGender == GENDER_FEMALE ) ? "al" : "llae" );
		case 8: return "ali";
		case 9: return ( ( nGender == GENDER_FEMALE ) ? "am" : "ama" );
		case 10: return ( ( nGender == GENDER_FEMALE ) ? "an" : "ana" );
		case 11: return ( ( nGender == GENDER_FEMALE ) ? "ar" : "ara" );
		case 12: return "ari";
		case 13: return "aro";
		case 14: return ( ( nGender == GENDER_FEMALE ) ? "as" : "ash" );
		case 15: return ( ( nGender == GENDER_FEMALE ) ? "ath" : "atha" );
		case 16: return ( ( nGender == GENDER_FEMALE ) ? "avel" : "avela" );
		case 17: return ( ( nGender == GENDER_FEMALE ) ? "brar" : "abrar" );
		case 18: return ( ( nGender == GENDER_FEMALE ) ? "dar" : "odar" );
		case 19: return ( ( nGender == GENDER_FEMALE ) ? "deth" : "eath" );
		case 20: return "dre";
		case 21: return ( ( nGender == GENDER_FEMALE ) ? "drim" : "drimme" );
		case 22: return "dul";
		case 23: return "ean";
		case 24: return ( ( nGender == GENDER_FEMALE ) ? "el" : "ele" );
		case 25: return "emar";
		case 26: return "en";
		case 27: return ( ( nGender == GENDER_FEMALE ) ? "er" : "erl" );
		case 28: return ( ( nGender == GENDER_FEMALE ) ? "ess" : "esti" );
		case 29: return ( ( nGender == GENDER_FEMALE ) ? "evar" : "evari" );
		case 30: return ( ( nGender == GENDER_FEMALE ) ? "fel" : "afel" );
		case 31: return ( ( nGender == GENDER_FEMALE ) ? "hal" : "ihal" );
		case 32: return ( ( nGender == GENDER_FEMALE ) ? "har" : "uhar" );
		case 33: return ( ( nGender == GENDER_FEMALE ) ? "hel" : "uhar" );
		case 34: return ( ( nGender == GENDER_FEMALE ) ? "ian" : "ianna" );
		case 35: return ( ( nGender == GENDER_FEMALE ) ? "iat" : "iata" );
		case 36: return ( ( nGender == GENDER_FEMALE ) ? "ik" : "aik" );
		case 37: return ( ( nGender == GENDER_FEMALE ) ? "il" : "ila" );
		case 38: return "im";
		case 39: return ( ( nGender == GENDER_FEMALE ) ? "in" : "ine" );
		case 40: return ( ( nGender == GENDER_FEMALE ) ? "ir" : "ira" );
		case 41: return ( ( nGender == GENDER_FEMALE ) ? "is" : "iss" );
		case 42: return ( ( nGender == GENDER_FEMALE ) ? "ith" : "lyth" );
		case 43: return ( ( nGender == GENDER_FEMALE ) ? "kash" : "okash" );
		case 44: return "ki";
		case 45: return ( ( nGender == GENDER_FEMALE ) ? "lan" : "lean" );
		case 46: return ( ( nGender == GENDER_FEMALE ) ? "lam" : "ilam" );
		case 47: return ( ( nGender == GENDER_FEMALE ) ? "lar" : "lirr" );
		case 48: return ( ( nGender == GENDER_FEMALE ) ? "las" : "lis" );
		case 49: return ( ( nGender == GENDER_FEMALE ) ? "lian" : "lia" );
		case 50: return ( ( nGender == GENDER_FEMALE ) ? "lis" : "lys" );
		case 51: return ( ( nGender == GENDER_FEMALE ) ? "lon" : "ellon" );
		case 52: return ( ( nGender == GENDER_FEMALE ) ? "lyn" : "llinn" );
		case 53: return ( ( nGender == GENDER_FEMALE ) ? "mah" : "mahs" );
		case 54: return ( ( nGender == GENDER_FEMALE ) ? "mil" : "umil" );
		case 55: return ( ( nGender == GENDER_FEMALE ) ? "mus" : "mas" );
		case 56: return ( ( nGender == GENDER_FEMALE ) ? "nal" : "inal" );
		case 57: return "nes";
		case 58: return ( ( nGender == GENDER_FEMALE ) ? "nin" : "nyn" );
		case 59: return ( ( nGender == GENDER_FEMALE ) ? "nis" : "anis" );
		case 60: return ( ( nGender == GENDER_FEMALE ) ? "on" : "onna" );
		case 61: return ( ( nGender == GENDER_FEMALE ) ? "or" : "oro" );
		case 62: return ( ( nGender == GENDER_FEMALE ) ? "oth" : "othi" );
		case 63: return ( ( nGender == GENDER_FEMALE ) ? "que" : "quen" );
		case 64: return ( ( nGender == GENDER_FEMALE ) ? "quis" : "quisa" );
		case 65: return ( ( nGender == GENDER_FEMALE ) ? "rah" : "raee" );
		case 66: return ( ( nGender == GENDER_FEMALE ) ? "rad" : "rahda" );
		case 67: return ( ( nGender == GENDER_FEMALE ) ? "rail" : "ria" );
		case 68: return ( ( nGender == GENDER_FEMALE ) ? "ran" : "reen" );
		case 69: return ( ( nGender == GENDER_FEMALE ) ? "reth" : "rath" );
		case 70: return ( ( nGender == GENDER_FEMALE ) ? "ro" : "ri" );
		case 71: return ( ( nGender == GENDER_FEMALE ) ? "ruil" : "eruil" );
		case 72: return ( ( nGender == GENDER_FEMALE ) ? "sal" : "isal" );
		case 73: return "san";
		case 74: return ( ( nGender == GENDER_FEMALE ) ? "sar" : "asar" );
		case 75: return ( ( nGender == GENDER_FEMALE ) ? "sel" : "isel" );
		case 76: return ( ( nGender == GENDER_FEMALE ) ? "she" : "sha" );
		case 77: return "spar";
		case 78: return ( ( nGender == GENDER_FEMALE ) ? "tae" : "itae" );
		case 79: return ( ( nGender == GENDER_FEMALE ) ? "tas" : "itas" );
		case 80: return ( ( nGender == GENDER_FEMALE ) ? "ten" : "iten" );
		case 81: return ( ( nGender == GENDER_FEMALE ) ? "thal" : "tha" );
		case 82: return ( ( nGender == GENDER_FEMALE ) ? "thar" : "ithar" );
		case 83: return ( ( nGender == GENDER_FEMALE ) ? "ther" : "ather" );
		case 84: return ( ( nGender == GENDER_FEMALE ) ? "thi" : "ethil" );
		case 85: return ( ( nGender == GENDER_FEMALE ) ? "thus" : "thas" );
		case 86: return ( ( nGender == GENDER_FEMALE ) ? "ti" : "til" );
		case 87: return ( ( nGender == GENDER_FEMALE ) ? "tril" : "tria" );
		case 88: return ( ( nGender == GENDER_FEMALE ) ? "ual" : "lua" );
		case 89: return ( ( nGender == GENDER_FEMALE ) ? "uath" : "luth" );
		case 90: return ( ( nGender == GENDER_FEMALE ) ? "us" : "ua" );
		case 91: return ( ( nGender == GENDER_FEMALE ) ? "van" : "vanna" );
		case 92: return ( ( nGender == GENDER_FEMALE ) ? "var" : "vara" );
		case 93: return ( ( nGender == GENDER_FEMALE ) ? "vain" : "avain" );
		case 94: return ( ( nGender == GENDER_FEMALE ) ? "via" : "avia" );
		case 95: return ( ( nGender == GENDER_FEMALE ) ? "vin" : "avin" );
		case 96: return ( ( nGender == GENDER_FEMALE ) ? "wyn" : "wynna" );
		case 97: return ( ( nGender == GENDER_FEMALE ) ? "ya" : "yaen" );
		case 98: return ( ( nGender == GENDER_FEMALE ) ? "yr" : "yn" );
		case 99: return "yth";
		default: return ( ( nGender == GENDER_FEMALE ) ? "zair" : "ezara" );
	}
	return "";
}

string RandomNameElf( int nGender ) {
	int rRoll = d10();
	string sName = "";
	if ( rRoll <= 5 ) {
		sName = RandomNameElfPrefix( nGender ) + RandomNameElfSuffix( nGender );
	} else if ( rRoll <= 8 ) {
		sName = RandomNameElfPrefix( nGender ) + RandomNameElfSuffix( nGender ) + RandomNameElfSuffix( nGender );
	} else if ( rRoll <= 9 ) {
		sName = RandomNameElfPrefix( nGender ) + RandomNameElfSuffix( nGender ) + "'" + RandomNameElfSuffix( nGender );
	} else {
		sName = RandomNameElfSuffix( nGender ) + "'" + RandomNameElfPrefix( nGender ) + RandomNameElfSuffix( nGender );
	}
	
	return GetStringUpperCase( GetSubString( sName, 1, 1 ) ) + GetSubString( sName, 2, GetStringLength( sName ) - 1 );
}