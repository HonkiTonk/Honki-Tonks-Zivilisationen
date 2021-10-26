pragma SPARK_Mode (On);

with Sf.Window.Event;
with Sf.System.Vector2;
with Sf.Window.Keyboard;
with Sf.Window.Mouse;

with SystemDatentypen;

package EingabeSystemeSFML is

   MausBewegt : Boolean;

   MausAmRand : SystemDatentypen.Tastenbelegung_Enum;

   MausRad : Float;

   TastaturTaste : Sf.Window.Keyboard.sfKeyCode;

   MausTaste : Sf.Window.Mouse.sfMouseButton;

   procedure TastenEingabe;
   procedure TastenEingabeErweitert;

private

   Mausbewegungen : Natural;
   
   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   ZeichenEingeben : Sf.Window.Event.sfEvent;

   function MausScrollen
     return SystemDatentypen.Tastenbelegung_Enum;

end EingabeSystemeSFML;
