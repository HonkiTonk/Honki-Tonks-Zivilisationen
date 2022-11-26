with LeseKIVariablen;

with KIEinheitFestlegenBewachenLogik;
with KIEinheitFestlegenHeilenLogik;
with KIEinheitFestlegenModernisierenLogik;
with KIEinheitFestlegenErkundenLogik;
with KIEinheitFestlegenAngreifenLogik;
with KIEinheitFestlegenNichtsLogik;

package body KINahkampfaufgabenLogik is

   procedure Nahkämpferaufgaben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        KIEinheitFestlegenBewachenLogik.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
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
            NormaleAufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when True =>
            Kriegsaufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end Nahkämpferaufgaben;
   
   
   
   procedure NormaleAufgaben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        KIEinheitFestlegenModernisierenLogik.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenHeilenLogik.Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenErkundenLogik.Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      else
         KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end NormaleAufgaben;
   
   
     
   procedure Kriegsaufgaben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        KIEinheitFestlegenAngreifenLogik.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      else
         NormaleAufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end Kriegsaufgaben;

end KINahkampfaufgabenLogik;
