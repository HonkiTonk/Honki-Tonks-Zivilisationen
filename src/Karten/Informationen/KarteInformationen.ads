pragma SPARK_Mode (On);

with GlobaleVariablen, EinheitStadtRecords, SonstigeDatentypen;
use SonstigeDatentypen;

package KarteInformationen is

   procedure KarteInformation
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);
   
private
   
   Sichtbar : Boolean;
   
   EinheitRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   StadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   
   procedure InformationenStadt
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   procedure InformationenAllgemein
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   procedure InformationenSichtbar
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure Kartenposition
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure Gecheatet
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldWissen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldGeld
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldProduktion
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldNahrung
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldAngriff
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldVerteidigung
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure Hügel
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

end KarteInformationen;
