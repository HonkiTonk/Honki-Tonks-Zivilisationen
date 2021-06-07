pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

package KarteStadt is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = 1);

   procedure Beschreibung
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

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

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   RasseUndPlatznummer : GlobaleRecords.RassePlatznummerRecord;
   
   procedure InformationenStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = 1);

   procedure SchleifeFenster
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.Stadtfeld;
      RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure AnzeigeStadtUmgebung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      YAchseExtern, XAchseExtern : in GlobaleDatentypen.Stadtfeld)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = 1);

end KarteStadt;
