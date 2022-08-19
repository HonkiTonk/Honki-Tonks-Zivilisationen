pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;
private with Sf.Graphics.Rect;
private with Sf.Graphics.Color;

with RassenDatentypen; use RassenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with SpielVariablen;
with StadtRecords;

private with ViewsSFML;

package BauAuswahlAnzeigeSFML is

   procedure BauAuswahlAnzeige
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AktuelleAuswahlExtern : in StadtRecords.BauprojektRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 (if AktuelleAuswahlExtern.Gebäude /= 0 then AktuelleAuswahlExtern.Einheit = 0)
               and
                 (if AktuelleAuswahlExtern.Einheit /= 0 then AktuelleAuswahlExtern.Gebäude = 0)
              );

private

   AktuelleTextbreite : Float;

   Text : Unbounded_Wide_Wide_String;
   AktuellesBauprojekt : StadtRecords.BauprojektRecord;

   TextPosition : Sf.System.Vector2.sfVector2f;

   Farbe : Sf.Graphics.Color.sfColor;

   type ViewflächenArray is array (ViewsSFML.BauviewAccesse'Range) of Sf.System.Vector2.sfVector2f;
   Viewfläche : ViewflächenArray := (others => (5.00, 5.00));

   KeineAnzeige : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 0.00, 0.00);

   type AnzeigebereichArray is array (ViewflächenArray'Range) of Sf.Graphics.Rect.sfFloatRect;
   Anzeigebereich : constant AnzeigebereichArray := (
                                                     1 => (0.00, 0.10, 0.50, 0.80),
                                                     2 => (0.50, 0.10, 0.50, 0.80),
                                                     3 => (0.50, 0.10, 0.50, 0.80),
                                                     4 => (0.00, 0.10, 0.50, 0.80),
                                                     5 => (0.00, 0.90, 1.00, 0.10)
                                                    );

   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive);

   procedure Einheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive);

   procedure InformationenGebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive);

   procedure InformationenEinheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive);

   procedure Aktuell
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ViewnummerExtern : in Positive)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

end BauAuswahlAnzeigeSFML;
