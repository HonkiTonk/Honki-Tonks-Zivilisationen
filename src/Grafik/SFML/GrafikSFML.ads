pragma SPARK_Mode (On);

with Sf.Window.Event;

package GrafikSFML is

   procedure GrafikSFML;

private

   ZeichenEingeben : Sf.Window.Event.sfEvent;

   procedure AnzeigeEingaben;



   function AnzeigeAuswahl
     return Boolean;

end GrafikSFML;
