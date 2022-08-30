pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar;

with NachGrafiktask;

package body MeldungFestlegenLogik is

   procedure MeldungFestlegen
     (MeldungExtern : in Positive)
   is begin
      
      -- Hier sollte immer erst die Zeit festgelegt werden, da die Grafik ja die Meldung auf 0 setzen kann.
      NachGrafiktask.StartzeitSpielmeldung := Ada.Calendar.Clock;
      NachGrafiktask.Spielmeldung := MeldungExtern;
      
   end MeldungFestlegen;

end MeldungFestlegenLogik;
