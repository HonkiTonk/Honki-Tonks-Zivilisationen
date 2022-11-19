with RassenDatentypen;
with EinheitenDatentypen;
with KartenDatentypen;
with KartenRecords;
with SpielVariablen;
with EinheitenRecords;

with LeseWeltkarteneinstellungen;

package TransporterSuchenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   function KoordinatenTransporterMitRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function EinheitAufTransporterSuchen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return EinheitenDatentypen.Transportplätze
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (TransporterExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 TransporterExtern.Nummer > 0
              );

   function HatTransporterLadung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer > 0
              );
   
   function FreierPlatz
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.Transportplätze
     with
       Pre => (
                 TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (TransporterExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   Transporterkapazität : EinheitenDatentypen.Transportplätze;

end TransporterSuchenLogik;
