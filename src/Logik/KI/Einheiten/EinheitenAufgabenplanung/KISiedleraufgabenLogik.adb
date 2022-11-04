pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;

with LeseWichtiges;

with KIDatentypen;

with KIAufgabenVerteiltLogik;
with KIEinheitFestlegenSiedelnLogik;
with KIEinheitFestlegenVerbesserungenLogik;
with KIEinheitFestlegenHeilenLogik;
with KIEinheitFestlegenAufloesenLogik;
with KIEinheitFestlegenFliehenLogik;
with KIEinheitFestlegenBefestigenLogik;
with KIEinheitFestlegenNichtsLogik;

-- Siedler auch Verbessern? äöü
package body KISiedleraufgabenLogik is

   procedure KISiedleraufgabenLogik
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      VorhandeneStädte := LeseWichtiges.AnzahlStädte (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      if
        VorhandeneStädte = 0
        and then
          KIEinheitFestlegenSiedelnLogik.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenVerbesserungenLogik.StadtumgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        (VorhandeneStädte < SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze
         and
           1 > KIAufgabenVerteiltLogik.AufgabenVerteilt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum))
        and then
          KIEinheitFestlegenSiedelnLogik.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenHeilenLogik.Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenAufloesenLogik.EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenFliehenLogik.Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenBefestigenLogik.Befestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
            
      else
         KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end KISiedleraufgabenLogik;

end KISiedleraufgabenLogik;