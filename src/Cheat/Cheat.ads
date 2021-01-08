with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

with GlobaleVariablen, GlobaleDatentypen, Karte, Karten, Eingabe, EinheitenDatenbank;
use GlobaleDatentypen;

package Cheat is
   
   procedure Menü (RasseExtern : in Integer);

private
   
   Taste : Wide_Wide_Character;
   
   AktuelleEinheit : Integer;
   AktuelleRasse : Integer;

   RasseZahl : Integer;
   Stadt : Integer;
   ID : Integer;

   procedure BeliebigeNächsteEinheit (RasseExtern : in Integer);
   procedure Informationen;
   procedure Sichtbarkeit (RasseExtern : in Integer);
   procedure GrundFestlegen;
   procedure EinheitFestlegen;
   procedure Geld;
   procedure Technologie;
   procedure VerbesserungFestlegen;
   procedure EinheitStatus;

end Cheat;
