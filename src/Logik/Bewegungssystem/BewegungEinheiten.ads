pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenRecords;
with EinheitenRecords;
with SpielVariablen;

private with StadtRecords;

package BewegungEinheiten is
   
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
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
                 SpielVariablen.Rassenbelegung (BewegendeEinheitExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 FeldBelegendeEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (FeldBelegendeEinheitExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (FeldBelegendeEinheitExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function FremderAufFeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FremdeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 FremdeEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (FremdeEinheitExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (FremdeEinheitExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function FremdeStadtAufFeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FremdeStadtExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 FremdeStadtExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (FremdeStadtExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (FremdeStadtExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end BewegungEinheiten;
