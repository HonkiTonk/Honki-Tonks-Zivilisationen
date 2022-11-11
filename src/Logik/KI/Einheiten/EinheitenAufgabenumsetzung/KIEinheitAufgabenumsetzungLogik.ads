with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

package KIEinheitAufgabenumsetzungLogik is
   pragma Elaborate_Body;

   procedure AufgabeUmsetzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
      
   AufgabeDurchführen : Boolean;

end KIEinheitAufgabenumsetzungLogik;
