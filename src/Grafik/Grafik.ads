pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar;

package Grafik is
   pragma Elaborate_Body;

   procedure Grafik;

private

   Startzeit : Ada.Calendar.Time;

   procedure AnzeigeEingaben;
   procedure GrafikanpassungenVorFensterleerung;
   procedure Eingaben;
   procedure AnzeigeSpielmeldungen;



   function AnzeigeAuswahl
     return Boolean;

end Grafik;
