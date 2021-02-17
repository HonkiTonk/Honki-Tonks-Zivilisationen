pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package KarteStadt is
   
   procedure AnzeigeStadt (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure Beschreibung (RasseExtern : in GlobaleDatentypen.Rassen);

private
   
   Stadtumgebungsgröße : GlobaleDatentypen.Kartenfeld := 1;
   Überhang : GlobaleDatentypen.Kartenfeld := 0;
   YAchsenabstraktion : GlobaleDatentypen.Kartenfeld;
   CursorKonstant : constant GlobaleDatentypen.Kartenfeld := 3;
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
   
   procedure FarbenStadt;
   procedure InformationenStadt (YAufschlag, XAufschlag : in GlobaleDatentypen.Kartenfeld; RasseExtern : in GlobaleDatentypen.Rassen);

end KarteStadt;
