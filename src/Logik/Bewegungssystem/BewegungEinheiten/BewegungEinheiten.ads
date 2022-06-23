pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenRecords;
with EinheitenRecords;
with SpielVariablen;
with SonstigeVariablen;
with StadtRecords;

package BewegungEinheiten is
   
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   ---------------------- Kan man das vielleicht mit den KIBerechnungen zusammenführen?
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   FeldPassierbar : Boolean;
   BewegungDurchführen : Boolean;
   
   StadtAufFeld : StadtRecords.RasseStadtnummerRecord;
      
   EinheitAufFeld : EinheitenRecords.RasseEinheitnummerRecord;

   NeuePosition : KartenRecords.AchsenKartenfeldNaturalRecord;
     
   procedure EigeneEinheitAufFeld
     (BewegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeldBelegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 BewegendeEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (BewegendeEinheitExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (BewegendeEinheitExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 FeldBelegendeEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (FeldBelegendeEinheitExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (FeldBelegendeEinheitExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function FremderAufFeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FremdeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 FremdeEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (FremdeEinheitExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (FremdeEinheitExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function FremdeStadtAufFeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FremdeStadtExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 FremdeStadtExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (FremdeStadtExtern.Rasse).Städtegrenze
               and
                 SonstigeVariablen.RassenImSpiel (FremdeStadtExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

end BewegungEinheiten;
