with RassenDatentypen;
with KartenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KartenRecords;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;

private with EinheitenDatentypen;

package TransporterLadungsverschiebungLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   
   procedure LadungVerschieben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
private
   
   Transporterkapazität : EinheitenDatentypen.Transportplätze;
   
   Ladungsnummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

end TransporterLadungsverschiebungLogik;
