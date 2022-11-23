with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with RassenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with StadtRecords;
with StadtKonstanten;

private with GrafikRecordKonstanten;

with LeseGrenzen;
with LeseRassenbelegung;

package BauauswahlGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.EinheitenIDMitNullWert;
   use type StadtDatentypen.GebäudeIDMitNullwert;

   procedure Bauauswahl
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AktuelleAuswahlExtern : in StadtRecords.BauprojektRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
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
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure Einheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure Aktuell
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ViewnummerExtern : in Positive)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

end BauauswahlGrafik;
