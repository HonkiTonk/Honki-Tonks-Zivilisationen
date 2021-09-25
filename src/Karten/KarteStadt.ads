pragma SPARK_Mode (On);

with GlobaleDatentypen, EinheitStadtRecords, GlobaleVariablen, KartenRecords;
use GlobaleDatentypen, KartenRecords;

package KarteStadt is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch);

private

   InformationenStadtAufrufen : Boolean;
   
   Stadtumgebungsgröße : GlobaleDatentypen.Stadtfeld;

   YAchsenabstraktion : GlobaleDatentypen.Kartenfeld;
   Aufschlag : GlobaleDatentypen.SichtweiteMitNullwert;
   CursorKonstant : constant GlobaleDatentypen.Sichtweite := 3;
   Cursor : GlobaleDatentypen.Kartenfeld;
   CursorYAchseabstraktion : GlobaleDatentypen.Kartenfeld;
   CursorXAchseabstraktion : GlobaleDatentypen.Kartenfeld;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
      
   procedure WeitereInformationen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch);

   procedure SchleifeAnsichtUmgebung
     (YAchseExtern : in GlobaleDatentypen.Stadtfeld;
      XAchseExtern : in GlobaleDatentypen.Stadtfeld;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch);

   procedure AnzeigeStadtUmgebung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      YAchseExtern : in GlobaleDatentypen.Stadtfeld;
      XAchseExtern : in GlobaleDatentypen.Stadtfeld)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch);
   
   procedure GrafischeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure GebäudeText
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure AnsichtUmgebung
     (YAchseExtern : in GlobaleDatentypen.Stadtfeld;
      XAchseExtern : in GlobaleDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure CursorDarstellung
     (YAchseExtern : in GlobaleDatentypen.Stadtfeld;
      XAchseExtern : in GlobaleDatentypen.Stadtfeld;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure GebäudeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID);
   
   procedure AnzeigeUmgebungCursor
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei);
   
   
   
   function Darstellung
     (YAchseExtern : in GlobaleDatentypen.Stadtfeld;
      XAchseExtern : in GlobaleDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;
   
   function AufschlagGebäude
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.SichtweiteMitNullwert;

end KarteStadt;
