pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with EinheitenRecords;
with SpielVariablen;
with Weltkarte;

private with StadtRecords;

package EinheitenbewegungLogik is
   pragma Elaborate_Body;
   
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BewegungDurchführenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function PositionÄndern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   function Einheitentausch
     (BewegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      StehendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 BewegendeEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (BewegendeEinheitExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (BewegendeEinheitExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 StehendeEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (StehendeEinheitExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (StehendeEinheitExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   FeldPassierbar : Boolean;
   BewegungDurchführen : Boolean;
   
   StadtAufFeld : StadtRecords.RasseStadtnummerRecord;
      
   EinheitAufFeld : EinheitenRecords.RasseEinheitnummerRecord;

   KeineÄnderung : constant KartenRecords.AchsenKartenfeldRecord := (0, 0, 0);
   NeueKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   BewegendeKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   StehendeKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
      
    
      
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

end EinheitenbewegungLogik;
