with RassenDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with EinheitenDatentypen;

with LeseGrenzen;
with LeseRassenbelegung;

package EinheitVerbessernLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function VerbesserungEinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   IDEinheit : EinheitenDatentypen.EinheitenID;
   
   IDNeueEinheit : EinheitenDatentypen.EinheitenIDMitNullWert;

end EinheitVerbessernLogik;
