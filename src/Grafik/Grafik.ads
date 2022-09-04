pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package Grafik is

   procedure Grafik;

private

   procedure AnzeigeEingaben;
   procedure GrafikanpassungenVorFensterleerung;
   procedure Eingaben;
   procedure AnzeigeSpielmeldungen;



   function AnzeigeAuswahl
     return Boolean;

end Grafik;
