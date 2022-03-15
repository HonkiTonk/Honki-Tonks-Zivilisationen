pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenRecords;
with KartenDatentypen;
with EinheitStadtDatentypen;
with SystemKonstanten;

package KarteStadtKonsole is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerMenschKonstante);

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
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerMenschKonstante);

   procedure SchleifeAnsichtUmgebung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerMenschKonstante);

   procedure AnzeigeStadtUmgebung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerMenschKonstante);
   
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
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure GebäudeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID);
   
   procedure AnzeigeUmgebungCursor
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in KartenDatentypen.UmgebungsbereichDrei);
   
   
   
   function Darstellung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;
   
   function AufschlagGebäude
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.SichtweiteMitNullwert;

end KarteStadtKonsole;
