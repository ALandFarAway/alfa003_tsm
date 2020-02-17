#include "silvy_univ_inc"
#include "acr_db_persist_i"

void main()
{
object oScroll;
if(GetTag(OBJECT_SELF) == "003_cr_slv_profabj")
  {oScroll = CreateItemOnObject("abr_scroll_1_shield", GetPCSpeaker(), 1);}

if(GetTag(OBJECT_SELF) == "003_cr_slv_profcon")
  {oScroll = CreateItemOnObject("abr_scroll_0_acidsplash", GetPCSpeaker(), 1);}

if(GetTag(OBJECT_SELF) == "003_cr_slv_profdiv")
  {oScroll = CreateItemOnObject("abr_scroll_3_seeinvis", GetPCSpeaker(), 1);}

if(GetTag(OBJECT_SELF) == "003_cr_slv_dean")
  {oScroll = CreateItemOnObject("abr_scroll_3_seeinvis", GetPCSpeaker(), 1);}

  if(GetTag(OBJECT_SELF) == "003_cr_slv_profenc")
  {oScroll = CreateItemOnObject("abr_scroll_2_touchidiocy", GetPCSpeaker(), 1);}

if(GetTag(OBJECT_SELF) == "003_cr_slv_profevo")
  {oScroll = CreateItemOnObject("abr_scroll_0_light", GetPCSpeaker(), 1);}

if(GetTag(OBJECT_SELF) == "003_cr_slv_profill")
  {oScroll = CreateItemOnObject("abr_scroll_2_invisibility", GetPCSpeaker(), 1);}

if(GetTag(OBJECT_SELF) == "003_cr_slv_profnec")
  {oScroll = CreateItemOnObject("abr_scroll_0_touchfatigue", GetPCSpeaker(), 1);}

if(GetTag(OBJECT_SELF) == "003_cr_slv_proftra")
  {oScroll = CreateItemOnObject("abr_scroll_1_enlarge", GetPCSpeaker(), 1);}

SetIdentified(oScroll, 1);
}