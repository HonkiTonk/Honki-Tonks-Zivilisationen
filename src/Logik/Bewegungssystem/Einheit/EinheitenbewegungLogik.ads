with RassenDatentypen;
with KartenDatentypen;
with KartenRecords;
with EinheitenRecords;
with SpielVariablen;

private with StadtRecords;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseRassenbelegung;

package EinheitenbewegungLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BewegungDurchführenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function PositionÄndern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   function Einheitentausch
     (BewegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      StehendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 BewegendeEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => BewegendeEinheitExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => BewegendeEinheitExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 StehendeEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => StehendeEinheitExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StehendeEinheitExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
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
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 FremdeEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => FremdeEinheitExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => FremdeEinheitExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function FremdeStadtAufFeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FremdeStadtExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 FremdeStadtExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => FremdeStadtExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => FremdeStadtExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

end EinheitenbewegungLogik;
