pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürRasse (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   procedure SichtbarkeitsprüfungFürEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen and GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0);

   procedure SichtbarkeitsprüfungFürStadt (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen and GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0);

   procedure Sichtbarkeit (InDerStadt : in Boolean; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord; RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure Farben (Einheit : in GlobaleDatentypen.KartenverbesserungEinheitenID; Verbesserung : in GlobaleDatentypen.KartenVerbesserung; Ressource, Grund : in GlobaleDatentypen.KartenGrund;
                     Cursor : in Boolean; RasseExtern, RasseIntern : in GlobaleDatentypen.RassenMitNullwert) with
     Pre => (Grund >= 0 and Ressource >= 0 and (if RasseExtern > 0 then GlobaleVariablen.RassenImSpiel (RasseExtern) = 1) and (if RasseIntern > 0 then GlobaleVariablen.RassenImSpiel (RasseIntern) = 1));

private

   NichtSichtbar : constant Wide_Wide_Character := ' ';

   Sichtweite : GlobaleDatentypen.Sichtweite := 2;
   Wert : Integer;

   Kartenwert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

end Sichtbarkeit;
