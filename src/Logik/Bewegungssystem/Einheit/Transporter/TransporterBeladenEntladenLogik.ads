with RassenDatentypen;
with SpielVariablen;
with EinheitenDatentypen;
with EinheitenRecords;

private with KartenRecords;

with LeseGrenzen;
with LeseRassenbelegung;

package TransporterBeladenEntladenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function TransporterBeladen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return Boolean
     with
       Pre => (
                 TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => TransporterExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => TransporterExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure EinheitAusladen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
     with
       Pre => (
                 TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => TransporterExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => TransporterExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   AlterTransporter : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   FreierPlatzNummer : EinheitenDatentypen.Transportplätze;
   Transporterkapazität : EinheitenDatentypen.Transportplätze;
   
   NeueKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end TransporterBeladenEntladenLogik;
