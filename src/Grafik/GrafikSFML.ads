pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package GrafikSFML is

   procedure GrafikSFML;

private

   procedure AnzeigeEingaben;
   procedure GrafikanpassungenVorFensterleerung;
   procedure Eingaben;
   procedure AnzeigeSpielmeldungen;



   function AnzeigeAuswahl
     return Boolean;

end GrafikSFML;
