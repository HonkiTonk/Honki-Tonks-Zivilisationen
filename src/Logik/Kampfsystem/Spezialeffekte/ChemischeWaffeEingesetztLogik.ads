with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;
private with KartenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package ChemischeWaffeEingesetztLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure ChemischeWaffeEingesetzt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
              );

private
   use type KartenDatentypen.Kartenfeld;

   Spezies : SpeziesDatentypen.Spezies_Enum;

   Gefahrenbereich : KartenRecords.EffektbereichRecord;
   Gefahrenhöhe : KartenRecords.EffekthöheRecord;

   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenwertFluss : KartenRecords.AchsenKartenfeldNaturalRecord;
   Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

   procedure Wasserverschmutzung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end ChemischeWaffeEingesetztLogik;
