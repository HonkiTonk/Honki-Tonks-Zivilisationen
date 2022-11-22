with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

with LeseGrenzen;
with LeseRassenbelegung;

package KIEinheitAufgabenumsetzungLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure AufgabeUmsetzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
private
      
   AufgabeDurchführen : Boolean;

end KIEinheitAufgabenumsetzungLogik;
