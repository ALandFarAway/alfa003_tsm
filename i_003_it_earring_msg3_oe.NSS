
//Wynna April 2021

 
#include "acr_items_i"
#include "acr_db_persist_i"
#include "acr_quest_i"
#include "dmfi_inc_langexe" 
#include "x2_inc_itemprop"	

void main()
{	
	object oItem = GetPCItemLastEquipped();
 	object oPC = GetPCItemLastEquippedBy();
	
	SendMessageToAllDMs(GetName(oPC) + " equipped a message ear ring and is receiving a message:");
	SendMessageToAllDMs("*The ear ring latches securely into your ear, sucked into your ear canal without pain, but too deep to dig out quickly.");
	SendMessageToAllDMs("*A deep, yet female, voice speaks into your ear in accented common.*  Laird, I blew it but it didnae summon what ye said t'would. We got something else, nae braw at all. Took a little bit, like ye said, but it wandered up, and it clearly does nae belong here. Had the beastie stabled, figuring tis weird enough ye'd want it. Ye sure the instrument was meant to-- *The voice breaks off on a squawk* What? What's that? No, you tin-eyed longlegs, in the sky!");
	DelayCommand(10.0, SendMessageToAllDMs("*The ear ring continues transmitting sounds into your ear, sounds of shouting, then running, then a discordant screech that raises gooseflesh all over you.*"));
	DelayCommand(20.0, SendMessageToAllDMs("*The same voice screams, not deep at all anymore.* Shite! They're here...  *A male voice cries out.* Feck, the winterlings are loose! It broke their cage! *A third voice, also male, shouts a gabbled warning that sound like:* MORE, hark ye! MORE, on the horizon!"));
	DelayCommand(30.0, SendMessageToAllDMs("*The original voice returns, shaking.* Here now, git ye away fro' me, ye spawns of Auril. Off! What are ye-- Nae! Stop!* Icy giggling sounds, then, and you hear the female voice speak, suddenly calm and concerned.* Oh, I'm sorry we caged ye, snowflake beasties. Is there aught I kin do t'make it up to ye?"));
	DelayCommand(40.0, SendMessageToAllDMs("*A tiny voice tinkles:* We have to signal for our way to return to our home. Guard our retreat from what you summoned, and these nasty caravan guards. You never trusted them, did you? They must be responsible for your master's summoning item going awry. *The tinkling voice grows more distant with every word."));
	DelayCommand(50.0, SendMessageToAllDMs("Aye, ye've the truth o' it! Treachery! Have at ye, ye sunny bastard! Look what ye've brought upon m' winterling friends! *The last sound the earring emits is a swelling chorus of approaching shrieks that sound as if they are growing nearer on all sides.*"));
	DelayCommand(60.0, SendMessageToAllDMs("*The ear ring pops out of your ear far enough to get a grip on it to remove if you wish."));
			
	SendMessageToPC(oPC, "*The ear ring latches securely into your ear, sucked into your ear canal without pain, but too deep to dig out quickly.");
	SendMessageToPC(oPC, "*A deep, yet female, voice speaks into your ear in accented common.*  Laird, I blew it but it didnae summon what ye said t'would. We got something else, nae braw at all. Took a little bit, like ye said, but it wandered up, and it clearly does nae belong here. Had the beastie stabled, figuring tis weird enough ye'd want it. Ye sure the instrument was meant to-- *The voice breaks off on a squawk* What? What's that? No, you tin-eyed longlegs, in the sky!");
	DelayCommand(10.0, SendMessageToPC(oPC, "*The ear ring continues transmitting sounds into your ear, sounds of shouting, then running, then a discordant screech that raises gooseflesh all over you.*"));
	DelayCommand(20.0, SendMessageToPC(oPC, "*The same voice screams, not deep at all anymore.* Shite! They're here...  *A male voice cries out.* Feck, the winterlings are loose! It broke their cage! *A third voice, also male, shouts a gabbled warning that sound like:* MORE, hark ye! MORE, on the horizon!"));
	DelayCommand(30.0, SendMessageToPC(oPC, "*The original voice returns, shaking.* Here now, git ye away fro' me, ye spawns of Auril. Off! What are ye-- Nae! Stop!* Icy giggling sounds, then, and you hear the female voice speak, suddenly calm and concerned.* Oh, I'm sorry we caged ye, snowflake beasties. Is there aught I kin do t'make it up to ye?"));
	DelayCommand(40.0, SendMessageToPC(oPC, "*A tiny voice tinkles:* We have to signal for our way to return to our home. Guard our retreat from what you summoned, and these nasty caravan guards. You never trusted them, did you? They must be responsible for your master's summoning item going awry. *The tinkling voice grows more distant with every word."));
	DelayCommand(50.0, SendMessageToPC(oPC, "Aye, ye've the truth o' it! Treachery! Have at ye, ye sunny bastard! Look what ye've brought upon m' winterling friends! *The last sound the earring emits is a swelling chorus of approaching shrieks that sound as if they are growing nearer on all sides.*"));
	DelayCommand(60.0, SendMessageToPC(oPC, "*The ear ring pops out of your ear far enough to get a grip on it to remove if you wish."));
		  		 
					 
}			  