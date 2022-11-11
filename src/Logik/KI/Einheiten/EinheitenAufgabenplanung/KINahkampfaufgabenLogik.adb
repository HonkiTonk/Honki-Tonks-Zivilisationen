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
      
      if
        KIEinheitFestlegenBewachenLogik.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenHeilenLogik.Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenModernisierenLogik.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenErkundenLogik.Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenAngreifenLogik.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      else
         KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end Nahkämpferaufgaben;

end KINahkampfaufgabenLogik;
