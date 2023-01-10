with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KIEinheitFestlegenNichtsLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure NichtsTun
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIEinheitFestlegenNichtsLogik;
