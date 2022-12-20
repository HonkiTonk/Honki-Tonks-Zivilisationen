with Sf.Window.Keyboard;
with Sf.Window.Mouse;
with Sf.System.Vector2;

with SystemRecords;

package NachLogiktask is
   pragma Elaborate_Body;
   
   Warten : Boolean := True;
   IntroAbwarten : Boolean := True;

   -- Eingabesystemwerte
   MausRad : Float;

   TastaturTaste : Sf.Window.Keyboard.sfKeyCode;

   MausTaste : Sf.Window.Mouse.sfMouseButton;

   EingegebenerText : SystemRecords.TextEingabeRecord;
   
   EingegebeneZahl : SystemRecords.ZahlenEingabeRecord;
   
   -- Diesen Wert hier immer im Grafiktask neu festlegen lassen, da die Verwendung der A/SFML Funktion im Logiktask zu Abstürzen führen kann.
   -- Ist das überhaupt korrekt oder lag das Problem woanders? äöü
   Mausposition : Sf.System.Vector2.sfVector2f;
   -- Eingabesystemwerte
   
end NachLogiktask;
