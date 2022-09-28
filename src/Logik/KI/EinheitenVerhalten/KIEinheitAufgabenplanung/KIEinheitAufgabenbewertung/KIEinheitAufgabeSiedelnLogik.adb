pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with StadtKonstanten;

with LeseWichtiges;
with LeseRassenDatenbank;

with KIAufgabenVerteiltLogik;

package body KIEinheitAufgabeSiedelnLogik is

   function NeueStadtBauenGehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      VorhandeneStädte := LeseWichtiges.AnzahlStädte (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      if
        VorhandeneStädte = StadtKonstanten.LeerNummer
      then
         return KIDatentypen.AufgabenWichtigkeitKlein'Last;
         
      elsif
        SpielVariablen.Allgemeines.Rundenanzahl > 20 * (Positive (VorhandeneStädte) + KIAufgabenVerteiltLogik.AufgabenVerteilt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                 AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum))
      then
         return 8;
         
      else
         null;
      end if;
      
      if
        LeseRassenDatenbank.RassenExpansion (EinheitRasseNummerExtern.Rasse) > 20
      then
         return 3;
         
      else
         return 0;
      end if;
      
   end NeueStadtBauenGehen;

end KIEinheitAufgabeSiedelnLogik;
