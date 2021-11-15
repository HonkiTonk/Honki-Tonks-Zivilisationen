pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Window.Event;
with Sf.Window.Keyboard;
with Sf.Window.Mouse;

package EingabeSystemeSFML is

   MausBewegt : Boolean;

   MausRad : Float;

   TastaturTaste : Sf.Window.Keyboard.sfKeyCode;

   MausTaste : Sf.Window.Mouse.sfMouseButton;

   procedure TastenEingabe;



   function TextEingeben
     return Unbounded_Wide_Wide_String;

private

   Mausbewegungen : Natural;

   EingegebenerName : Unbounded_Wide_Wide_String;

   ZeichenEingeben : Sf.Window.Event.sfEvent;

   TextEingegebenEvent : Sf.Window.Event.sfEvent;

end EingabeSystemeSFML;
