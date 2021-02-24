pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package KarteStadt is

   procedure AnzeigeStadtNeu (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure AnzeigeStadt (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure Beschreibung (RasseExtern : in GlobaleDatentypen.Rassen);

private

   FeldBelegt : Boolean;
   
   StadtumgebungsgrößeFest : GlobaleDatentypen.Stadtfeld;
   FelderFensterYAchse : constant GlobaleDatentypen.Stadtfeld := Karten.StadtkarteArray'First (1) + 7;
   FelderFensterXAchse : constant GlobaleDatentypen.Stadtfeld := Karten.StadtkarteArray'Last (2) - 7;

   StadtumgebungsgrößeVariabel : GlobaleDatentypen.Kartenfeld;

   Überhang : GlobaleDatentypen.Kartenfeld := 0;
   YAchsenabstraktion : GlobaleDatentypen.Kartenfeld;
   CursorKonstant : constant GlobaleDatentypen.KartenfeldPositiv := 3;
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
   
   procedure InformationenStadt (YAufschlag, XAufschlag : in GlobaleDatentypen.Kartenfeld; StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

end KarteStadt;
