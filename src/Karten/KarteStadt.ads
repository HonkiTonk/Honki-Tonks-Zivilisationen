pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

package KarteStadt is

   procedure AnzeigeStadt (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen and GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) = 1
             and GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) = 1);

   procedure Beschreibung (RasseExtern : in GlobaleDatentypen.Rassen);

private

   FeldBelegt : Boolean;
   InformationenStadtAufrufen : Boolean;
   
   Stadtumgebungsgröße : GlobaleDatentypen.Stadtfeld;
   KonstanterWertEins : constant GlobaleDatentypen.Sichtweite := 1;
   KonstanterWertSieben : constant GlobaleDatentypen.Sichtweite := 7;

   YAchsenabstraktion : GlobaleDatentypen.Kartenfeld;
   CursorKonstant : constant GlobaleDatentypen.Sichtweite := 3;
   Cursor : GlobaleDatentypen.Kartenfeld;
   CursorYAchseabstraktion : GlobaleDatentypen.Kartenfeld;
   CursorXAchseabstraktion : GlobaleDatentypen.Kartenfeld;

   Nahrungsgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Ressourcengewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Geldgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Wissensgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;

   Wert : Integer;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   
   RasseUndPlatznummer : GlobaleRecords.RassePlatznummerRecord;
   
   procedure InformationenStadt (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen and GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) = 1);

   procedure SchleifeFenster (YAchse, XAchse : in GlobaleDatentypen.Stadtfeld; Rasse : in GlobaleDatentypen.Rassen) with
     Pre => (Rasse in GlobaleDatentypen.Rassen and GlobaleVariablen.RassenImSpiel (Rasse) = 1);

end KarteStadt;
