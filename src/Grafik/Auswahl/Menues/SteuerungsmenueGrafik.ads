with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.Window.Keyboard;
private with Sf.System.Vector2;
private with Sf.Graphics.Color;

private with GrafikRecordKonstanten;
private with InteraktionAuswahl;
private with MenueKonstanten;

private with SteuerungsauswahlLogik;

package SteuerungsmenueGrafik is
   pragma Elaborate_Body;

   procedure Steuerungsmenü
     (AuswahlExtern : in Integer);
   
private
   
   UnbekannteTaste : constant Positive := 191;
   ArrayAnfang : Positive;
   ArrayEnde : Positive;
      
   AktuelleBelegung : Sf.Window.Keyboard.sfKeyCode;
   
   Textbreite : Float;
   
   Text : Unbounded_Wide_Wide_String;
      
   ViewflächeAufteilung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   ViewflächeBelegung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   Farbe : Sf.Graphics.Color.sfColor;
   
   type AufteilungArray is array (InteraktionAuswahl.PositionenSteuerungsaufteilung'Range) of Positive;
   Aufteilung : constant AufteilungArray := (
                                             1 => MenueKonstanten.AllgemeineSteuerung,
                                             2 => MenueKonstanten.Einheitensteuerung,
                                             3 => MenueKonstanten.Stadtsteuerung
                                            );
   
   
   
   function Steuerungsaufteilung
     (AuswahlExtern : in Integer;
      WelcheSteuerungExtern : in SteuerungsauswahlLogik.Tastenbelegungskategorie_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Steuerungsaufteilung'Result.x >= 0.00
                and
                  Steuerungsaufteilung'Result.y >= 0.00
               );
   
   function Steuerung
     (AuswahlExtern : in Integer;
      WelcheSteuerungExtern : in SteuerungsauswahlLogik.Tastenbelegungskategorie_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Steuerung'Result.x >= 0.00
                and
                  Steuerung'Result.y >= 0.00
               );
   
   function TextFestlegen
     (WelcheSteuerungExtern : in SteuerungsauswahlLogik.Tastenbelegungskategorie_Enum;
      WelcheZeileExtern : in Positive)
      return Wide_Wide_String;

end SteuerungsmenueGrafik;
