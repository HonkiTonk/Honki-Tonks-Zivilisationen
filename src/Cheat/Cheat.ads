with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

with GlobaleVariablen, GlobaleDatentypen, Karte, Karten, Eingabe, EinheitenDatenbank;
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
   procedure Geld;
   procedure Technologie;
   procedure VerbesserungFestlegen;
   procedure EinheitStatus;

end Cheat;
