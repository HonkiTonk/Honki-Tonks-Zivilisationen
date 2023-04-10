with SpeziesDatentypen;
with EinheitenKonstanten;
with EinheitenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with KIDatentypen;

package KIEinheitenAufgabenumsetzungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Aufgabenumsetzung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
private
      
   AufgabeDurchführen : Boolean;
   
   AktuelleBeschäftigung : KIDatentypen.Einheit_Aufgabe_Enum;

end KIEinheitenAufgabenumsetzungLogik;
