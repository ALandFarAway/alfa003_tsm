
//dancer_onperception

//quick and cheap way to get guys to play animations indefinitely: Dancing and playing a flute.

// DBR 5/31/06


void main()
{
object oPC = GetLastPerceived();

if (!GetIsPC(oPC)) return;

if (!GetLastPerceptionSeen()) return;
object oTarget;
oTarget = OBJECT_SELF;
	if (GetLocalInt(GetModule(),"Stop Ambient Life"))
	{
		return;
	}

	int nRandom=Random(5);
	if (nRandom==0)
		PlayCustomAnimation(OBJECT_SELF,"touchheart", 1);
	else if (nRandom==1)
		PlayCustomAnimation(OBJECT_SELF,"throwarmsloop", 1);
	else if (nRandom==2)
		PlayCustomAnimation(OBJECT_SELF,"dance03", 1);
	else if (nRandom==3)
		PlayCustomAnimation(OBJECT_SELF,"dance01", 1);	
	else if (nRandom==4)
		PlayCustomAnimation(OBJECT_SELF,"dance02", 1);

}