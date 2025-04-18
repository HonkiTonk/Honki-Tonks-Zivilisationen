private with Ada.Strings.Wide_Wide_Unbounded;

private with Sf.Window.Keyboard;
private with Sf.System.Vector2;
private with Sf.Graphics.Color;
private with Sf.Graphics.Rect;

private with GrafikRecordKonstanten;
private with InteraktionAuswahl;
private with MenueKonstanten;
private with TastenbelegungDatentypen;

with SystemRecords;

package SteuerungsmenueGrafik is
   pragma Elaborate_Body;

   procedure Steuerungsmenü
     (AuswahlExtern : in SystemRecords.DoppelauswahlRecord);
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Vollauswahl : Boolean;
   
   UnbekannteTaste : constant Positive := 191;
   ArrayAnfang : Positive;
   ArrayEnde : Positive;
      
   AktuelleBelegung : Sf.Window.Keyboard.sfKeyCode;
   
   Anzeigemodifikator : constant Float := 1.00;
   Scrollweite : Float;
   AktuelleAuflösungshöhe : Float;
   
   Text : Unbounded_Wide_Wide_String;
      
   ViewflächeAufteilung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   ViewflächeBelegung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Bewegung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.Nullposition;
   Textposition : Sf.System.Vector2.sfVector2f;
   Auswahlverhältnis : Sf.System.Vector2.sfVector2f;
   
   Farbe : Sf.Graphics.Color.sfColor;
   
   Anzeigebereich : Sf.Graphics.Rect.sfFloatRect;
   
   type AufteilungArray is array (InteraktionAuswahl.PositionenSteuerungsaufteilung'Range) of Positive;
   Aufteilung : constant AufteilungArray := (
                                             1 => MenueKonstanten.AllgemeineSteuerung,
                                             2 => MenueKonstanten.Einheitensteuerung,
                                             3 => MenueKonstanten.Stadtsteuerung
                                            );
   
   
   
   function Steuerungsaufteilung
     (AuswahlExtern : in Integer;
      WelcheSteuerungExtern : in TastenbelegungDatentypen.Tastenbelegungskategorie_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Steuerungsaufteilung'Result.x >= 0.00
                and
                  Steuerungsaufteilung'Result.y >= 0.00
               );
   
   function Steuerung
     (AuswahlExtern : in Integer;
      WelcheSteuerungExtern : in TastenbelegungDatentypen.Tastenbelegungskategorie_Enum;
      MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 MaximaleTextbreiteExtern >= 0.00
              ),
         
       Post => (
                  Steuerung'Result >= 0.00
               );
   
   function TextFestlegen
     (WelcheSteuerungExtern : in TastenbelegungDatentypen.Tastenbelegungskategorie_Enum;
      WelcheZeileExtern : in Positive)
      return Wide_Wide_String;

end SteuerungsmenueGrafik;
