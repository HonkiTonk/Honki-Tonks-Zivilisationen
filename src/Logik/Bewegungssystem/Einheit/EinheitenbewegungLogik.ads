with RassenDatentypen;
with KartenDatentypen;
with KartenRecords;
with EinheitenRecords;
with EinheitenKonstanten;

private with StadtRecords;
private with StadtKonstanten;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseRassenbelegung;

package EinheitenbewegungLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
      
   function Einheitentausch
     (BewegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      StehendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 BewegendeEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => BewegendeEinheitExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => BewegendeEinheitExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 StehendeEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => StehendeEinheitExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StehendeEinheitExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
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
   Zielkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
      
    
      
   function FremderAufFeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FremdeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 FremdeEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => FremdeEinheitExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => FremdeEinheitExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function FremdeStadtAufFeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FremdeStadtExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 FremdeStadtExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => FremdeStadtExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => FremdeStadtExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

end EinheitenbewegungLogik;
