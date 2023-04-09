with KartenRecords;
with EinheitenRecords;
with EinheitenKonstanten;
with SpeziesDatentypen;
with KartenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package KIEinheitFestlegenWegeLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;
   use type SpeziesDatentypen.Spieler_Enum;

   function WegAnlegbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function StädteVerbinden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              ),
         
       Post => (
                  StädteVerbinden'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  StädteVerbinden'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );
   
private
   
   Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitFestlegenWegeLogik;
