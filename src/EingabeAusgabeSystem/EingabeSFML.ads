pragma SPARK_Mode (On);

with Sf.Window.Event;

package EingabeSFML is

   procedure MausScrollen;



   function TastenEingabe
     return Sf.Window.Event.sfEvent;

   function TastenEingabeErweitert
     return Sf.Window.Event.sfEvent;

private

   ZeichenEingeben : Sf.Window.Event.sfEvent;

end EingabeSFML;
