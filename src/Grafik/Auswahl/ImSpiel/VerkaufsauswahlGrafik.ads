private with Sf.System.Vector2;

with SpeziesDatentypen;
with StadtDatentypen;

private with GrafikRecordKonstanten;

with LeseSpeziesbelegung;

package VerkaufsauswahlGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Verkaufsauswahl
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AktuelleAuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

private

   AktuelleTextbreite : Float;

   Textposition : Sf.System.Vector2.sfVector2f;

   type ViewflächenArray is array (GrafikRecordKonstanten.Verkausmenübereich'Range) of Sf.System.Vector2.sfVector2f;
   Viewfläche : ViewflächenArray := (others => GrafikRecordKonstanten.StartgrößeView);

   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   procedure InformationenGebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end VerkaufsauswahlGrafik;
