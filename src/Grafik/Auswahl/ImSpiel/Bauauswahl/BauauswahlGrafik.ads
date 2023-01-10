with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with StadtRecords;
with StadtKonstanten;

private with GrafikRecordKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package BauauswahlGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.EinheitenIDMitNullWert;
   use type StadtDatentypen.GebäudeIDMitNullwert;

   procedure Bauauswahl
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      AktuelleAuswahlExtern : in StadtRecords.BauprojektRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 (if AktuelleAuswahlExtern.Gebäude /= 0 then AktuelleAuswahlExtern.Einheit = 0)
               and
                 (if AktuelleAuswahlExtern.Einheit /= 0 then AktuelleAuswahlExtern.Gebäude = 0)
              );

private

   Textbreite : Float;

   Text : Unbounded_Wide_Wide_String;

   AktuellesBauprojekt : StadtRecords.BauprojektRecord;

   ViewflächeGebäude : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   ViewflächeEinheiten : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   ViewflächeAktuell : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
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
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end BauauswahlGrafik;
