with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

with LeseGrenzen;

package KIEinheitUmsetzenModernisierenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   NullWert : Boolean;

end KIEinheitUmsetzenModernisierenLogik;
