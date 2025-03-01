private with Ada.Calendar;

private with Sf.System.Vector2;

private with GrafikRecordKonstanten;
private with SonstigesKonstanten;

package IntroGrafik is
   pragma Elaborate_Body;

   procedure Intro;

private
   use Ada.Calendar;

   Spielstart : Boolean := True;

   AktuellerBuchstabe : Natural := 0;

   Introtext : Wide_Wide_String (SonstigesKonstanten.Spielname'Range) := "                          ";

   Textbreite : Float;
   Leerwert : Float;

   Buchstabenanzeige : constant Duration := 0.50;

   Startzeit : Time;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   Skalierung : Sf.System.Vector2.sfVector2f;



   function Titel
     return Boolean;

   function Namen
     return Boolean;

end IntroGrafik;
