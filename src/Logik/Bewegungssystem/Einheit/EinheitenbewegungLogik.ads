with SpeziesDatentypen;
with KartenDatentypen;
with KartenRecords;
with EinheitenRecords;
with EinheitenKonstanten;
with StadtRecords;
with StadtKonstanten;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package EinheitenbewegungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
      
   function Einheitentausch
     (BewegendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StehendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 BewegendeEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => BewegendeEinheitExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => BewegendeEinheitExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StehendeEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => StehendeEinheitExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StehendeEinheitExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function EinheitentauschPrüfung
     (BewegendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StehendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 BewegendeEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => BewegendeEinheitExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => BewegendeEinheitExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StehendeEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => StehendeEinheitExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StehendeEinheitExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function BewegungPrüfen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function FremderAufFeld
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      FremdeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 FremdeEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => FremdeEinheitExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => FremdeEinheitExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function FremdeStadtAufFeld
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      FremdeStadtExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 FremdeStadtExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => FremdeStadtExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => FremdeStadtExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function NurTauschen
     (BewegendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StehendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 BewegendeEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => BewegendeEinheitExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => BewegendeEinheitExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StehendeEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => StehendeEinheitExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StehendeEinheitExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   FeldPassierbar : Boolean;
   
   StadtAufFeld : StadtRecords.SpeziesStadtnummerRecord;
      
   EinheitAufFeld : EinheitenRecords.SpeziesEinheitnummerRecord;

   BewegendeKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   StehendeKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   Zielkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end EinheitenbewegungLogik;
