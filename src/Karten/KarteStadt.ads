pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

package KarteStadt is

   procedure AnzeigeStadt (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure Beschreibung (RasseExtern : in GlobaleDatentypen.Rassen);

private

   FeldBelegt : Boolean;
   
   Stadtumgebungsgröße : GlobaleDatentypen.Stadtfeld;
   KonstanterWertEins : constant GlobaleDatentypen.Sichtweite := 1;
   KonstanterWertSieben : constant GlobaleDatentypen.Sichtweite := 7;

   Überhang : GlobaleDatentypen.Kartenfeld := 0;
   YAchsenabstraktion : GlobaleDatentypen.Kartenfeld;
   CursorKonstant : constant GlobaleDatentypen.Sichtweite := 3;
   Cursor : GlobaleDatentypen.Kartenfeld;
   CursorYAchsePlus : GlobaleDatentypen.Kartenfeld;
   CursorXAchsePlus : GlobaleDatentypen.Kartenfeld;
   Nahrungsgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Ressourcengewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Geldgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Wissensgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   YAchse : GlobaleDatentypen.Kartenfeld;
   XAchse : GlobaleDatentypen.Kartenfeld;

   Wert : Integer;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   
   RasseUndPlatznummer : GlobaleRecords.RassePlatznummerRecord;
   
   procedure InformationenStadt (YAufschlag, XAufschlag : in GlobaleDatentypen.Kartenfeld; StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure SchleifeFenster (YAchse, XAchse : in GlobaleDatentypen.Stadtfeld; Rasse : in GlobaleDatentypen.Rassen);

end KarteStadt;
