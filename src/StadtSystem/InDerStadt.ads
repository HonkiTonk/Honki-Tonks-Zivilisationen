pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package InDerStadt is

   procedure InDerStadt (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) with
     Pre => StadtNummer in GlobaleVariablen.StadtGebaut'Range (2);

   procedure StadtProduktionPrüfen (RasseExtern : in GlobaleDatentypen.RassenMitNullwert; StadtNummer : in Natural) with
     Pre => StadtNummer in GlobaleVariablen.StadtGebaut'Range (2);

   procedure BelegteStadtfelderFreigeben (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) with
     Pre => StadtNummer in GlobaleVariablen.StadtGebaut'Range (2);



   function StadtBauen (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   function StadtBauenPrüfen (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

private

   BauMöglich : Boolean;

   Taste : Wide_Wide_Character;

   Überhang : Integer;
   Stadtart : Integer;
   Wahl : Integer;

   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   RelativeCursorPositionY : GlobaleDatentypen.Kartenfeld;
   RelativeCursorPositionX : GlobaleDatentypen.Kartenfeld;

   KartenWert : GlobaleRecords.AchsenAusKartenfeldRecord;

   procedure StadtProduktionPrüfenBerechnung (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) with
     Pre => StadtNummer in GlobaleVariablen.StadtGebaut'Range (2);

end InDerStadt;
