pragma SPARK_Mode (On);

with Sf.Window.Event;
with Sf.System.Vector2;
with Sf.Window.Keyboard;
with Sf.Window.Mouse;

with SystemDatentypen;

package EingabeSFML is

   MausAmRand : SystemDatentypen.Tastenbelegung_Enum;
   TastaturTaste : Sf.Window.Keyboard.sfKeyCode;
   MausTaste : Sf.Window.Mouse.sfMouseButton;

   procedure TastenEingabe;
   procedure TastenEingabeErweitert;

private

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   ZeichenEingeben : Sf.Window.Event.sfEvent;

   function MausScrollen
     return SystemDatentypen.Tastenbelegung_Enum;

end EingabeSFML;
