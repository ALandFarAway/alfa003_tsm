// gc_check_level
/*
    This script checks to see if the PC's level is less than a value
        nLevel  = The level the PC should be under to return true
        nMP     = If in MP - set this to 1 if you want to make sure all players are
                  the appropriate level
*/
// Wynna 6/14/21

int StartingConditional(int nLevel, int nMP)
{

    object oPC = GetPCSpeaker();

    if ( nMP == 0 )
    {
        if ( GetHitDice(oPC) < nLevel ) return TRUE;
    }
    else
    {
        oPC = GetFirstPC();
        while( GetIsObjectValid(oPC) )
        {
            if( GetHitDice(oPC) >= nLevel ) return FALSE;
            oPC = GetNextPC();
        }
        return TRUE;
    }

    return FALSE;

}