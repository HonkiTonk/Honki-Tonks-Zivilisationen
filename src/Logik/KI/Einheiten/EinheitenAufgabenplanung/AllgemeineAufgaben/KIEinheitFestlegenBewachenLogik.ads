with SpeziesDatentypen;
with EinheitenKonstanten;
with EinheitenRecords;

private with KartenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KIEinheitFestlegenBewachenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spezies_Enum;
   use type SpeziesDatentypen.Spieler_Enum;

   function StadtBewachen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
private
   
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitFestlegenBewachenLogik;
