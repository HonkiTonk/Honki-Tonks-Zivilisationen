pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard;

private with Sf.Window.Mouse;

with TastenbelegungDatentypen;

package TasteneingabeLogik is

   function Tastenwert
     return TastenbelegungDatentypen.Tastenbelegung_Enum;
   
   function TastenbelegungAnpassen
     return Sf.Window.Keyboard.sfKeyCode;
   
private
   
   Maustaste : Sf.Window.Mouse.sfMouseButton;
   
   Taste : Sf.Window.Keyboard.sfKeyCode;
   
end TasteneingabeLogik;
