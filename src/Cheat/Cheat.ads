pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package Cheat is
   
   procedure Menü (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

private
   
   Taste : Wide_Wide_Character;

   AktuelleRasse : GlobaleDatentypen.Rassen;
   RasseZahl : Integer;
   
   AktuelleEinheit : Integer;
   Stadt : Integer;
   ID : Integer;

   procedure BeliebigeNächsteEinheit (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure Informationen;
   procedure Sichtbarkeit (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure GrundFestlegen (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure EinheitFestlegen;
   procedure Geld (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure Technologie (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure VerbesserungFestlegen (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure RassenverteilungÄndern;

end Cheat;
