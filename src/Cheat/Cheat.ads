with GlobaleDatentypen;
use GlobaleDatentypen;

package Cheat is
   
   procedure Menü (RasseExtern : in GlobaleDatentypen.Rassen);

private
   
   Taste : Wide_Wide_Character;
   
   AktuelleEinheit : Integer;
   AktuelleRasse : GlobaleDatentypen.Rassen;

   RasseZahl : GlobaleDatentypen.Rassen;
   Stadt : Integer;
   ID : Integer;

   procedure BeliebigeNächsteEinheit (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure Informationen;
   procedure Sichtbarkeit (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure GrundFestlegen;
   procedure EinheitFestlegen;
   procedure Geld (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure Technologie (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure VerbesserungFestlegen;
   procedure EinheitStatus;

end Cheat;
