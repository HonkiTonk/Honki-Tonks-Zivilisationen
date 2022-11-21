with RassenDatentypen;
with StadtDatentypen;
with StadtRecords;
with SpielVariablen;
with EinheitenRecords;
with EinheitenDatentypen;

with LeseGrenzen;

package MeldungenSetzenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure MeldungenRundenende;
   
   procedure StadtmeldungSetzen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EreignisExtern : in StadtDatentypen.Stadt_Meldungen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
              );
   
   procedure EinheitmeldungSetzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      EreignisExtern : in EinheitenDatentypen.Einheit_Meldung_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
              );
   
private
   
   StadtMeldung : StadtDatentypen.Stadt_Meldung_Art_Enum;
   
   EinheitMeldung : EinheitenDatentypen.Einheit_Meldung_Art_Enum;

end MeldungenSetzenLogik;
