with EinheitenRecords;
with SpeziesDatentypen;
with EinheitenKonstanten;

private with EinheitenDatentypen;

with LeseSpeziesbelegung;
with LeseGrenzen;

package KIEinheitenAufgabenplanungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   function Aufgabenplanung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
private
   
   EinheitID : EinheitenDatentypen.EinheitenID;

end KIEinheitenAufgabenplanungLogik;
