pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

package KarteInformationen is

   procedure KarteInformation
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
   
private
   
   EinheitNummer : GlobaleDatentypen.MaximaleEinheiten;
   
   Verteidigungsbonus : GlobaleDatentypen.GrundwerteNRGWVA;
   Nahrungsgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Ressourcengewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Geldgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Wissensgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   
   EinheitRasseNummer : GlobaleRecords.RassePlatznummerRecord;
   StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord;
   
   procedure InformationenRundenanzahl;
   
   procedure InformationenGeldmenge
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
     
   procedure InformationenGeldGewinn
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
     
   procedure InformationenForschungsprojekt
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
     
   procedure InformationenForschungszeit
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
     
   procedure InformationenForschungsmenge
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
     
   procedure InformationenForschungsrate
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   
   procedure InformationenEinheiten
     (RasseExtern : in GlobaleDatentypen.Rassen;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   
   procedure InformationenStadt
     (RasseExtern : in GlobaleDatentypen.Rassen;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   
   procedure InformationenAllgemein
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

end KarteInformationen;
