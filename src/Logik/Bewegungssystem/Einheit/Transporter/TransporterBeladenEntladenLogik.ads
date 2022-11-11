with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenDatentypen;
with EinheitenRecords;

private with KartenRecords;

package TransporterBeladenEntladenLogik is
   pragma Elaborate_Body;

   function TransporterBeladen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return Boolean
     with
       Pre => (
                 TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (TransporterExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure EinheitAusladen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
     with
       Pre => (
                 TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (TransporterExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   AlterTransporter : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   FreierPlatzNummer : EinheitenDatentypen.Transportplätze;
   Transporterkapazität : EinheitenDatentypen.Transportplätze;
   
   NeueKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end TransporterBeladenEntladenLogik;
