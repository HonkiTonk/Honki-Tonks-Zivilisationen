with LeseKIVariablen;

with KIEinheitFestlegenBewachenLogik;
with KIEinheitFestlegenHeilenLogik;
with KIEinheitFestlegenModernisierenLogik;
with KIEinheitFestlegenErkundenLogik;
with KIEinheitFestlegenAngreifenLogik;
with KIEinheitFestlegenNichtsLogik;

package body KIKampfaufgabenLogik is

   procedure Nahkämpferaufgaben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      case
        KIEinheitFestlegenBewachenLogik.StadtBewachen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when True =>
            return;
         
         when False =>
            null;
      end case;
      
      case
        LeseKIVariablen.Kriegszustand
      is
         when False =>
            NormaleAufgaben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when True =>
            Kriegsaufgaben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
   end Nahkämpferaufgaben;
   
   
   
   procedure NormaleAufgaben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      if
        KIEinheitFestlegenModernisierenLogik.EinheitVerbessern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenHeilenLogik.Heilen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenErkundenLogik.Erkunden (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         null;
         
      else
         KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end if;
      
   end NormaleAufgaben;
   
   
     
   procedure Kriegsaufgaben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      if
        KIEinheitFestlegenAngreifenLogik.Angreifen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         null;
         
      else
         NormaleAufgaben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end if;
      
   end Kriegsaufgaben;

end KIKampfaufgabenLogik;
