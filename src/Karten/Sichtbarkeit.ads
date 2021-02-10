pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, Karten, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

package Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürRasse (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure SichtbarkeitsprüfungFürEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure SichtbarkeitsprüfungFürStadt (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => StadtRasseUndNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure Sichtbarkeit (InDerStadt : Boolean; Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure Farben (Einheit : GlobaleDatentypen.EinheitenIDMitNullWert; Verbesserung : GlobaleDatentypen.KartenVerbesserung; Ressource, Grund : in GlobaleDatentypen.KartenGrund;
                     Cursor : in Boolean; RasseExtern, RasseIntern : in GlobaleDatentypen.RassenMitNullwert) with
     Pre => Grund >= 0 and Ressource >= 0;

private

   NichtSichtbar : constant Wide_Wide_Character := ' ';

   Sichtweite : GlobaleDatentypen.Sichtweite := 2;
   Wert : Integer;

   Kartenwert : GlobaleRecords.AchsenAusKartenfeldRecord;

end Sichtbarkeit;
