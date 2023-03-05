with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with StadtRecords;
with StadtGrafikRecords;

private with GrafikRecordKonstanten;

with LeseSpeziesbelegung;

package BauauswahlGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.EinheitenIDMitNullWert;
   use type StadtDatentypen.GebäudeIDMitNullwert;

   procedure Bauauswahl
     (BauauswahlExtern : in StadtGrafikRecords.BaumenüGrafikRecord;
      AktuelleAuswahlExtern : in StadtRecords.BauprojektRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => BauauswahlExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 (if AktuelleAuswahlExtern.Gebäude /= 0 then AktuelleAuswahlExtern.Einheit = 0)
               and
                 (if AktuelleAuswahlExtern.Einheit /= 0 then AktuelleAuswahlExtern.Gebäude = 0)
              );

private

   Textbreite : Float;

   Text : Unbounded_Wide_Wide_String;

   ViewflächeGebäude : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   ViewflächeEinheiten : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   ViewflächeAktuell : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;

   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   procedure Einheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   procedure Aktuell
     (BauauswahlExtern : in StadtGrafikRecords.BaumenüGrafikRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => BauauswahlExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end BauauswahlGrafik;
