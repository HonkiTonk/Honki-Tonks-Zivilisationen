with Ada.Calendar; use Ada.Calendar;

package Grafik is
   pragma Elaborate_Body;

   procedure Grafik;

private

   Startzeit : Time;

   procedure AnzeigeEingaben;
   procedure GrafikanpassungenVorFensterleerung;
   procedure Eingaben;
   procedure AnzeigeSpielmeldungen;



   function AnzeigeAuswahl
     return Boolean;

end Grafik;
