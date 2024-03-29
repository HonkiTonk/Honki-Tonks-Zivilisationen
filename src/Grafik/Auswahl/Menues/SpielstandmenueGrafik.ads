with Ada.Calendar; use Ada.Calendar;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

private with GrafikRecordKonstanten;
private with TextArrays;
private with SpielstandDatentypen;

with SystemRecords;

package SpielstandmenueGrafik is
   pragma Elaborate_Body;

   procedure Spielstandmenü
     (AuswahlExtern : in SystemRecords.MehrfachauswahlRecord);
   
private
   
   SpeichernLaden : Boolean;
   MehrereSeiten : Boolean;
   
   SpielstandlisteAnfang : constant Positive := 4;
   SpielstandlisteEnde : constant Positive := 13;
   MehrAnzeigen : constant Positive := 14;
   NeuerSpielstand : constant Positive := 15;
   
   Textbreite : Float;
   NeueTextbreite : Float;
   
   ViewflächeAufteilung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   ViewflächeBelegung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   Skalierung : Sf.System.Vector2.sfVector2f;

   Farbe : Sf.Graphics.Color.sfColor;
      
   Spielstand : TextArrays.SpielstandArray;
   
   Erstellungszeit : Time;
   
   
   
   function Spielstandaufteilung
     (AuswahlExtern : in Integer;
      SpielstandartExtern : in SpielstandDatentypen.Spielstand_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Spielstandaufteilung'Result.x >= 0.00
                and
                  Spielstandaufteilung'Result.y >= 0.00
               );
   
   function Textanzeige
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
              ),
         
       Post => (
                  Textanzeige'Result.x >= 0.00
                and
                  Textanzeige'Result.y >= 0.00
               );
      
   function TextSetzen
     (TextExtern : in Wide_Wide_String)
      return Wide_Wide_String;
   
end SpielstandmenueGrafik;
