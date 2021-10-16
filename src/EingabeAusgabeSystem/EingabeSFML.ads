pragma SPARK_Mode (On);

with Sf.Window.Keyboard;
with Sf.Window.Event;

package EingabeSFML is

   procedure MausScrollen;



   function TastenEingabe
     return Sf.Window.Keyboard.sfKeyCode;

private

   ZeichenEingeben : Sf.Window.Event.sfEvent;

end EingabeSFML;
