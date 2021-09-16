pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

package KarteInformationen is

   procedure KarteInformation
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch);
   
private
   
   Sichtbar : Boolean;
   
   EinheitRasseNummer : GlobaleRecords.RassePlatznummerRecord;
   StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord;
   
   procedure InformationenStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   procedure InformationenAllgemein
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   procedure InformationenSichtbar
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure Kartenposition
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure Gecheatet
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldWissen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldGeld
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldProduktion
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldNahrung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldAngriff
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldVerteidigung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure Hügel
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);

end KarteInformationen;
