pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenRecords;
with KartenDatentypen;
with EinheitStadtDatentypen;

package KarteStadt is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch);

private

   InformationenStadtAufrufen : Boolean;
   
   Stadtumgebungsgröße : KartenDatentypen.Stadtfeld;

   YAchsenabstraktion : KartenDatentypen.Kartenfeld;
   Aufschlag : KartenDatentypen.SichtweiteMitNullwert;
   CursorKonstant : constant KartenDatentypen.Sichtweite := 3;
   Cursor : KartenDatentypen.Kartenfeld;
   CursorYAchseabstraktion : KartenDatentypen.Kartenfeld;
   CursorXAchseabstraktion : KartenDatentypen.Kartenfeld;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
      
   procedure WeitereInformationen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch);

   procedure SchleifeAnsichtUmgebung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);

   procedure AnzeigeStadtUmgebung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch);
   
   procedure GrafischeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure GebäudeText
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure AnsichtUmgebung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure CursorDarstellung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure GebäudeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID);
   
   procedure AnzeigeUmgebungCursor
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in KartenDatentypen.LoopRangeMinusDreiZuDrei);
   
   
   
   function Darstellung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;
   
   function AufschlagGebäude
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.SichtweiteMitNullwert;

end KarteStadt;
