with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;
private with KartenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package KIEinheitFestlegenFliehenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Fliehen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

private
   use type KartenDatentypen.Kartenfeld;

   ZielKoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;
   MöglicheKoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;



   function Ziel
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  Ziel'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  Ziel'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

end KIEinheitFestlegenFliehenLogik;
