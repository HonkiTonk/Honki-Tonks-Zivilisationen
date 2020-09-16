with Ada.Wide_Wide_Text_IO, GlobaleVariablen, KartenDatenbank, Karten, Eingabe, Einlesen;
use Ada.Wide_Wide_Text_IO;

package BewegungssystemCursor is

   procedure BewegungCursorRichtung (Karte : in Boolean; Richtung : in Wide_Wide_Character);
   procedure GeheZuCursor;

private

   subtype Änderung is Integer range -1 .. 1;

   XÄnderung : Änderung;
   YÄnderung : Änderung;

   YPosition : Integer;
   XPosition : Integer;
   
   procedure BewegungCursorBerechnen;
   procedure BewegungCursorBerechnenStadt;

end BewegungssystemCursor;
