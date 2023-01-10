with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with StadtDatentypen;

private with GrafikRecordKonstanten;

with LeseSpeziesbelegung;

package BauauswahlGebaeudeGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Gebäudeinformationen
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   type GebäudetexteArray is array (1 .. 10) of Unbounded_Wide_Wide_String;
   Gebäudetexte : GebäudetexteArray;

   Textbreite : Float;
   
   ViewflächeInformationen : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   ViewflächeBeschreibung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;

   procedure Gebäudebeschreibung
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end BauauswahlGebaeudeGrafik;
