pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

package Cheat is
   
   procedure Menü (RasseExtern : in GlobaleDatentypen.Rassen);

private
   
   Taste : Wide_Wide_Character;

   AktuelleRasse : GlobaleDatentypen.Rassen;
   RasseZahl : Integer;
   
   AktuelleEinheit : Integer;
   Stadt : Integer;
   ID : Integer;

   procedure BeliebigeNächsteEinheit (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure Informationen;
   procedure Sichtbarkeit (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure GrundFestlegen (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure EinheitFestlegen;
   procedure Geld (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure Technologie (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure VerbesserungFestlegen (RasseExtern : in GlobaleDatentypen.Rassen);

end Cheat;
