pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with StadtKonstanten;

with LeseWichtiges;
with SchreibeEinheitenGebaut;
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
         SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum);
         return 11;
         
      elsif
        SpielVariablen.Allgemeines.Rundenanzahl
          > (Positive (VorhandeneStädte)
             + KIAufgabenVerteilt.AufgabenVerteilt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum))
        * 20
      then
         SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum);
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
