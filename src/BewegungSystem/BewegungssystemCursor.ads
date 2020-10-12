with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ausgabe, GlobaleDatentypen, GlobaleVariablen, KartenDatenbank, Karten, Eingabe, SchleifenPruefungen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package BewegungssystemCursor is

   procedure BewegungCursorRichtung (Karte : in Boolean; Richtung : in Wide_Wide_Character);
   procedure GeheZuCursor;

private

   subtype Änderung is Integer range -1 .. 1;

   XÄnderung : Änderung;
   YÄnderung : Änderung;

   YPosition : Integer;
   XPosition : Integer;

   KartenWert : GlobaleDatentypen.RückgabewertFürSchleifenPrüfungRecord;
   
   procedure BewegungCursorBerechnen (YÄnderung, XÄnderung : in Änderung);
   procedure BewegungCursorBerechnenStadt;

end BewegungssystemCursor;
