with EinheitenRecords;
with EinheitenKonstanten;
with SpeziesDatentypen;
with ProduktionDatentypen;

with LeseSpeziesbelegung;
with LeseGrenzen;

package AufgabeFestlegenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure AufgabeFestlegen
     (ArbeitExtern : in EinheitenRecords.ArbeitVorleistungRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Nullsetzung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   Arbeitszeit : ProduktionDatentypen.Arbeitszeit;

end AufgabeFestlegenLogik;
