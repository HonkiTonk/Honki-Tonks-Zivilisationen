with GlobaleVariablen, KartenDatenbank, Karten;

package BewegungssystemCursor is

   procedure BewegungCursorRichtung (Karte : in Boolean; Richtung : in Wide_Wide_Character);

private

   subtype Änderung is Integer range -1 .. 1;

   XÄnderung : Änderung;
   YÄnderung : Änderung;
   
   procedure BewegungCursorBerechnen;
   procedure BewegungCursorBerechnenStadt;

end BewegungssystemCursor;
