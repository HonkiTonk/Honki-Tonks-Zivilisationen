pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, Karten, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

package Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürRasse (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure SichtbarkeitsprüfungFürEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure SichtbarkeitsprüfungFürStadt (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure Sichtbarkeit (InDerStadt : Boolean; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure Farben (Einheit : GlobaleDatentypen.KartenverbesserungEinheitenID; Verbesserung : GlobaleDatentypen.KartenVerbesserung; Ressource, Grund : in GlobaleDatentypen.KartenGrund;
                     Cursor : in Boolean; RasseExtern, RasseIntern : in GlobaleDatentypen.RassenMitNullwert) with
     Pre => Grund >= 0 and Ressource >= 0;

private

   NichtSichtbar : constant Wide_Wide_Character := ' ';

   Sichtweite : GlobaleDatentypen.Sichtweite := 2;
   Wert : Integer;

   Kartenwert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

end Sichtbarkeit;
