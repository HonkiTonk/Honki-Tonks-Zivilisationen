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
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch);

   procedure Beschreibung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch);

private

   InformationenStadtAufrufen : Boolean;
   
   Stadtumgebungsgröße : GlobaleDatentypen.Stadtfeld;
   KonstanterWertEins : constant GlobaleDatentypen.Sichtweite := 1;
   KonstanterWertSieben : constant GlobaleDatentypen.Sichtweite := 7;

   YAchsenabstraktion : GlobaleDatentypen.Kartenfeld;
   Aufschlag : GlobaleDatentypen.KartenfeldPositivMitNullwert;
   CursorKonstant : constant GlobaleDatentypen.Sichtweite := 3;
   Cursor : GlobaleDatentypen.Kartenfeld;
   CursorYAchseabstraktion : GlobaleDatentypen.Kartenfeld;
   CursorXAchseabstraktion : GlobaleDatentypen.Kartenfeld;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord;
   
   procedure InformationenStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch);

   procedure SchleifeFenster
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.Stadtfeld;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch);

   procedure AnzeigeStadtUmgebung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      YAchseExtern, XAchseExtern : in GlobaleDatentypen.Stadtfeld)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch);

end KarteStadt;
