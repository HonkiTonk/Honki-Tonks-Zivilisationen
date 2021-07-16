pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

private

   AnzahlStädte : GlobaleDatentypen.MaximaleStädteMitNullWert;
   SiedlerVorhanden : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   VerteidigerVorhanden : GlobaleDatentypen.MaximaleEinheitenMitNullWert;

   StädteMitGleichemBauprojekt : Natural;

end KIStadt;
