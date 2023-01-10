with SpeziesDatentypen;
with KartenDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;
with KartenRecords;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

private with EinheitenDatentypen;

package TransporterLadungsverschiebungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   
   procedure LadungVerschieben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
private
   
   Transporterkapazität : EinheitenDatentypen.Transportplätze;
   
   Ladungsnummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

end TransporterLadungsverschiebungLogik;
