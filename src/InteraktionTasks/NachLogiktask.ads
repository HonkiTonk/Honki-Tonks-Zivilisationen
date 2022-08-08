pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard;
with Sf.Window.Mouse;
with Sf.System.Vector2;

with SystemRecords;

package NachLogiktask is
   
   Warten : Boolean := True;

   -- Eingabesystemwerte
   MausRad : Float;

   TastaturTaste : Sf.Window.Keyboard.sfKeyCode;

   MausTaste : Sf.Window.Mouse.sfMouseButton;

   EingegebenerText : SystemRecords.TextEingabeRecord;
   
   -- Diesen Wert hier immer im Grafiktask neu festlegen lassen, da die Verwendung der A/SFML Funktion im Logiktask zu Abstürzen führen kann.
   Mausposition : Sf.System.Vector2.sfVector2f;
   -- Eingabesystemwerte
   
   
   
end NachLogiktask;
