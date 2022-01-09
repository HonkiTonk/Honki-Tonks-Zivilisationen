pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with KartenRecords;
with EinheitStadtRecords;
with GlobaleVariablen;

package BewegungEinheiten is
   
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_Mensch);
   
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_Mensch);
   
private
   
   FeldPassierbar : Boolean;
   BewegungDurchführen : Boolean;
      
   EinheitAufFeld : EinheitStadtRecords.RassePlatznummerRecord;
   StadtAufFeld : EinheitStadtRecords.RassePlatznummerRecord;

   NeuePosition : KartenRecords.AchsenKartenfeldPositivRecord;
     
   procedure EigeneEinheitAufFeld
     (BewegendeEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FeldBelegendeEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   
   
   function FremderAufFeld
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FremdeEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;
   
   function FremdeStadtAufFeld
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FremdeStadtExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;

end BewegungEinheiten;
