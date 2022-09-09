pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with SpielVariablen;
with StadtRecords;

private with GrafikRecordKonstanten;

package BauauswahlGrafik is

   procedure Bauauswahl
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AktuelleAuswahlExtern : in StadtRecords.BauprojektRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
               and
                 (if AktuelleAuswahlExtern.Gebäude /= 0 then AktuelleAuswahlExtern.Einheit = 0)
               and
                 (if AktuelleAuswahlExtern.Einheit /= 0 then AktuelleAuswahlExtern.Gebäude = 0)
              );

private

   AktuelleTextbreite : Float;

   Text : Unbounded_Wide_Wide_String;
   AktuellesBauprojekt : StadtRecords.BauprojektRecord;

   Textposition : Sf.System.Vector2.sfVector2f;

   type ViewflächenArray is array (GrafikRecordKonstanten.Baumenübereich'Range) of Sf.System.Vector2.sfVector2f;
   Viewfläche : ViewflächenArray := (others => GrafikRecordKonstanten.StartgrößeView);

   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure Einheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure InformationenGebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure InformationenEinheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure Aktuell
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ViewnummerExtern : in Positive)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

end BauauswahlGrafik;
