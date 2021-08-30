pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package Cheat is
   
   procedure Menü
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch);
   
   procedure KarteInfosEinheiten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze);
   
   procedure KarteInfosFeld
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch);
   
   procedure KarteStadtInfos
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            StadtRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze);
   
   GewonnenDurchCheat : Boolean := False;

private
   
   ErsteAnzeige : Boolean;

   procedure Informationen;
   
   procedure Sichtbarkeit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch);

end Cheat;
