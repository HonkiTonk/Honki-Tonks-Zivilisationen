pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenRecords;
with EinheitStadtRecords;
with SpielVariablen;
with SonstigeVariablen;

package BewegungEinheiten is
   
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      PositionÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);
   
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);
   
private
   
   FeldPassierbar : Boolean;
   BewegungDurchführen : Boolean;
      
   EinheitAufFeld : EinheitStadtRecords.RasseEinheitnummerRecord;
   StadtAufFeld : EinheitStadtRecords.RasseEinheitnummerRecord;

   NeuePosition : KartenRecords.AchsenKartenfeldPositivRecord;
     
   procedure EigeneEinheitAufFeld
     (BewegendeEinheitExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      FeldBelegendeEinheitExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);
   
   
   
   function FremderAufFeld
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      FremdeEinheitExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return Boolean;
   
   function FremdeStadtAufFeld
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      FremdeStadtExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return Boolean;

end BewegungEinheiten;
