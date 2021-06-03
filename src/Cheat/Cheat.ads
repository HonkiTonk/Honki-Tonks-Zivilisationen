pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package Cheat is
   
   procedure Menü
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
   
   procedure KarteInfos
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0
          and
            EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2));

private
   
   Taste : Wide_Wide_Character;

   AktuelleRasseEinheit : GlobaleDatentypen.Rassen := 1;
   AktuelleRasseStadt : GlobaleDatentypen.Rassen := 1;

   KartenGrundID : GlobaleDatentypen.KartenGrund;
   RasseNummer : Integer;
   
   AktuelleEinheit : GlobaleDatentypen.MaximaleEinheiten := 1;
   AktuelleStadt : GlobaleDatentypen.MaximaleStädte := 1;
   EinheitID : Integer;
   VerbesserungID : GlobaleDatentypen.KartenVerbesserung;

   EinheitPosition : GlobaleRecords.RassePlatznummerRecord;

   procedure BeliebigeNächsteEinheit
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure BeliebigeNächsteStadt
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure Informationen;
   
   procedure Sichtbarkeit
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure GrundFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure EinheitFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure Geld
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure Technologie
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure VerbesserungFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure RassenverteilungÄndern;

end Cheat;
