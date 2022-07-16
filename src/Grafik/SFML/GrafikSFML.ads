pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package GrafikSFML is

   procedure GrafikSFML;

private

   procedure AnzeigeEingaben;
   procedure AnzeigeEditoren;
   procedure GrafikanpassungenVorFensterleerung;
   procedure Eingaben;



   function AnzeigeAuswahl
     return Boolean;

end GrafikSFML;
