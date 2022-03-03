
  //Created by Wynna; 3/4, 2022


void main()
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    
   AssignCommand(oUser, ActionCastSpellAtObject(SPELL_POWER_WORD_KILL, oUser, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
 
}