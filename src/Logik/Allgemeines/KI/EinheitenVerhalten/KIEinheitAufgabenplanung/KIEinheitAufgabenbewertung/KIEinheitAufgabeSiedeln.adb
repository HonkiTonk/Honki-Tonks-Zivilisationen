pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with StadtKonstanten;

with LeseWichtiges;
with LeseRassenDatenbank;

with KIAufgabenVerteilt;

package body KIEinheitAufgabeSiedeln is

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
        SpielVariablen.Allgemeines.Rundenanzahl > 30 * (Positive (VorhandeneStädte) + KIAufgabenVerteilt.AufgabenVerteilt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                            AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum))
      then
         return 5;
         
      else
         null;
      end if;
      
      if
        LeseRassenDatenbank.RassenExpansion (EinheitRasseNummerExtern.Rasse) > 10
      then
         return 3;
         
      else
         return 2;
      end if;
      
   end NeueStadtBauenGehen;

end KIEinheitAufgabeSiedeln;
