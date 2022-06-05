

void main()
{
    object oDM = GetItemActivator();
	if(oDM == OBJECT_INVALID)
		{oDM = OBJECT_SELF;
		}
    
    object oDestroy = GetItemActivatedTarget();
	
	DestroyObject(oDestroy);

}