pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.Window.Keyboard;
private with Sf.System.Vector2;

private with GrafikRecordKonstanten;

private with SteuerungsauswahlLogik;

package SteuerungsmenueGrafik is
   pragma Elaborate_Body;

   procedure Steuerungsmenü
     (AuswahlExtern : in Integer);
   
private
      
   ArrayAnfang : Positive;
   ArrayEnde : Positive;
      
   AktuelleBelegung : Sf.Window.Keyboard.sfKeyCode;
   
   Textbreite : Float;
   
   Text : Unbounded_Wide_Wide_String;
      
   ViewflächeAufteilung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   ViewflächeBelegung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   
   
   function Steuerungsaufteilung
     (AuswahlExtern : in Integer;
      WelcheSteuerungExtern : in SteuerungsauswahlLogik.Kategorie_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Steuerungsaufteilung'Result.x >= 0.00
                and
                  Steuerungsaufteilung'Result.y >= 0.00
               );
   
   function Steuerung
     (AuswahlExtern : in Integer;
      WelcheSteuerungExtern : in SteuerungsauswahlLogik.Kategorie_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Steuerung'Result.x >= 0.00
                and
                  Steuerung'Result.y >= 0.00
               );
   
   function TextFestlegen
     (WelcheSteuerungExtern : in SteuerungsauswahlLogik.Kategorie_Enum;
      WelcheZeileExtern : in Positive)
      return Wide_Wide_String;

end SteuerungsmenueGrafik;
