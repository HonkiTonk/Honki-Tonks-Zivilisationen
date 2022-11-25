with EinheitenRecords;
with RassenDatentypen;
with EinheitenKonstanten;

private with EinheitenDatentypen;

with LeseRassenbelegung;
with LeseGrenzen;

package KIEinheitenAufgabenplanungLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   
   function Aufgabenplanung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   EinheitID : EinheitenDatentypen.EinheitenID;

end KIEinheitenAufgabenplanungLogik;
