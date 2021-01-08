with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with Anzeige, GlobaleDatentypen, GlobaleVariablen, KartenDatenbank, Karten, Eingabe, SchleifenPruefungen;
use GlobaleDatentypen;

package BewegungssystemCursor is

   procedure BewegungCursorRichtung (Karte : in Boolean; Richtung : in Wide_Wide_Character; RasseExtern : in Integer);
   procedure GeheZuCursor (RasseExtern : in Integer);

private

   YÄnderung : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   XÄnderung : GlobaleDatentypen.LoopRangeMinusEinsZuEins;

   YPosition : GlobaleDatentypen.Kartenfeld;
   XPosition : GlobaleDatentypen.Kartenfeld;

   Wert : Integer;
   Stellenanzahl : Integer;

   KartenWert : GlobaleDatentypen.AchsenAusKartenfeld;
   
   procedure BewegungCursorBerechnen (YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins; RasseExtern : in Integer);
   procedure BewegungCursorBerechnenStadt (YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins; RasseExtern : in Integer);

end BewegungssystemCursor;
