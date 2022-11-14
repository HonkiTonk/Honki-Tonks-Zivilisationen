with RassenDatentypen;
with KartenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KartenRecords;
with Weltkarte;

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
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
private
   
   Transporterkapazität : EinheitenDatentypen.Transportplätze;
   
   Ladungsnummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

end TransporterLadungsverschiebungLogik;
