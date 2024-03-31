private with Sf.System.Vector2;
private with Sf.Graphics.Color;

private with GrafikRecordKonstanten;
private with TextArrays;
private with AuswahlKonstanten;
private with MenueKonstanten;

with SystemDatentypen;
with SystemRecords;

package SpielstandmenueGrafik is
   pragma Elaborate_Body;

   procedure Spielstandmenü
     (AuswahlExtern : in SystemRecords.MehrfachauswahlRecord;
      SpielstandartExtern : in SystemDatentypen.Spielstand_Enum;
      SpeichernLadenExtern : in Boolean);
   
private
   
   MehrereSeiten : Boolean;
   
   -- Das +3 ist als Ausgleich notwendig da die Menütexte die ersten Plätze belegt.
   SpielstandlisteAnfang : constant Positive := AuswahlKonstanten.SpielstandlisteAnfang + MenueKonstanten.SchleifenanpassungGrafikLogik + MenueKonstanten.SpielstandausgleichLogikGrafik;
   SpielstandlisteEnde : constant Positive := AuswahlKonstanten.SpielstandlisteEnde + MenueKonstanten.SchleifenanpassungGrafikLogik + MenueKonstanten.SpielstandausgleichLogikGrafik;
   MehrAnzeigen : constant Positive := AuswahlKonstanten.MehrAnzeigen + MenueKonstanten.SchleifenanpassungGrafikLogik + MenueKonstanten.SpielstandausgleichLogikGrafik;
   NeuerSpielstand : constant Positive := AuswahlKonstanten.NeuerSpielstand + MenueKonstanten.SchleifenanpassungGrafikLogik + MenueKonstanten.SpielstandausgleichLogikGrafik;
   Lademenü : constant Positive := 1;
   Speichermenü : constant Positive := 2;
   
   Textbreite : Float;
   NeueTextbreite : Float;
   
   ViewflächeAufteilung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   ViewflächeBelegung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   Skalierung : Sf.System.Vector2.sfVector2f;

   Farbe : Sf.Graphics.Color.sfColor;
      
   Spielstand : TextArrays.SpielstandArray;
   
   
   
   function Spielstandaufteilung
     (AuswahlExtern : in Integer;
      SpielstandartExtern : in SystemDatentypen.Spielstand_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Spielstandaufteilung'Result.x >= 0.00
                and
                  Spielstandaufteilung'Result.y >= 0.00
               );
   
   function Textanzeige
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AuswahlExtern : in Integer;
      SpielstandartExtern : in SystemDatentypen.Spielstand_Enum;
      SpeichernLadenExtern : in Boolean)
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
     (TextExtern : in Wide_Wide_String;
      SpielstandartExtern : in SystemDatentypen.Spielstand_Enum)
      return Wide_Wide_String;
   
end SpielstandmenueGrafik;
