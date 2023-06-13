with Ada.Calendar; use Ada.Calendar;

private with Sf.System.Vector2;

private with GrafikRecordKonstanten;

package BildrateAnzeigenGrafik is
   pragma Elaborate_Body;

   procedure Bildrate;
   
private
   
   AktuelleBildrate : Positive;
   
   LetzteZeit : Time := Clock;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;

end BildrateAnzeigenGrafik;
