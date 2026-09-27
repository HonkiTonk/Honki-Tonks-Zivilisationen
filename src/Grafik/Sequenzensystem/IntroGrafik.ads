private with Ada.Calendar;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

private with GrafikRecordKonstanten;
private with SonstigesKonstanten;

package IntroGrafik is
   pragma Elaborate_Body;

   procedure Intro;

private
   use Ada.Calendar;

   StartSpiel : Boolean := True;
   StartEntwickler : Boolean := True;
   StartHelfer : Boolean := True;

   AktuellerBuchstabe : Natural := 0;

   Introtext : Wide_Wide_String (SonstigesKonstanten.Spielname'Range) := "                          ";

   Textbreite : Float;
   Leerwert : Float;

   Buchstabenanzeige : constant Duration := 0.20;
   Anzeigezeit : constant Duration := 2.00;

   ZeitStart : Time;
   ZeitEntwickler : Time;
   ZeitHelfer : Time;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   Skalierung : Sf.System.Vector2.sfVector2f;

   Farbe : Sf.Graphics.Color.sfColor;



   function Titel
     return Boolean;

   function Entwickler
     return Boolean;

   function Helfer
     return Boolean;

end IntroGrafik;
