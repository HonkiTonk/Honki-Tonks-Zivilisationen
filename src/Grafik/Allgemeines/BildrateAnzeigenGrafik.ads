private with Ada.Calendar;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

private with GrafikRecordKonstanten;

private with UmwandlungssystemHTB3;

package BildrateAnzeigenGrafik is
   pragma Elaborate_Body;

   procedure Bildrate;
   
private
   use Ada.Calendar;
   
   AktuelleBildrate : Float;
   ZielBildrate : Float;
   Zeitunterschied : Float;
   
   LetzteZeit : Time := Clock;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   
   Farbe : Sf.Graphics.Color.sfColor;
   
   
   
   function KommazahlAlsString is new UmwandlungssystemHTB3.Kommazahlenstring (Kommazahl => Float);

end BildrateAnzeigenGrafik;
