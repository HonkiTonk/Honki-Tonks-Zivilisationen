with Sf.Window.Keyboard;
with Sf.Window.Mouse;

with SystemRecords;

package NachLogiktask is
   pragma Elaborate_Body;
   
   SoundWarten : Boolean := True;
   MusikWarten : Boolean := True;
   GrafikWarten : Boolean := True;
   IntroAbwarten : Boolean := True;

   -- Eingabesystemwerte
   MausRad : Float;

   TastaturTaste : Sf.Window.Keyboard.sfKeyCode;

   MausTaste : Sf.Window.Mouse.sfMouseButton;

   EingegebenerText : SystemRecords.TextEingabeRecord;
   
   EingegebeneZahl : SystemRecords.ZahlenEingabeRecord;
      
end NachLogiktask;
