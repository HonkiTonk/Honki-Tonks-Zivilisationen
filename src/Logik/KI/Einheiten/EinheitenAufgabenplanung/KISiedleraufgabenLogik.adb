with StadtKonstanten;

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
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      VorhandeneStädte := LeseWichtiges.AnzahlStädte (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      if
        VorhandeneStädte = StadtKonstanten.LeerNummer
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
         
         -- Hier noch eine Prüfung einbauen ob eine andere Einheit auf das Feld dieser Einheit will und dann aus dem Weg gehen? äöü
      else
         KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end KISiedleraufgabenLogik;

end KISiedleraufgabenLogik;
