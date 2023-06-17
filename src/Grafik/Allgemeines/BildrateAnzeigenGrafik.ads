with Ada.Calendar; use Ada.Calendar;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

private with GrafikRecordKonstanten;

package BildrateAnzeigenGrafik is
   pragma Elaborate_Body;

   procedure Bildrate;
   
private
   
   AktuelleBildrate : Positive;
   
   ZielBildrate : Natural;
   
   Zeitunterschied : Float;
   
   LetzteZeit : Time := Clock;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   
   Farbe : Sf.Graphics.Color.sfColor;

end BildrateAnzeigenGrafik;
