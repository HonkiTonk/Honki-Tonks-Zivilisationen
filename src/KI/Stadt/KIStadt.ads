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
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = 2);

private

   SiedlerVorhanden : Natural;
   VerteidigerVorhanden : Natural;
   StädteMitGleichemBauprojekt : Natural;
   AnzahlStädte : GlobaleDatentypen.MaximaleStädteMitNullWert;

end KIStadt;
