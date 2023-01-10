with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KIEinheitFestlegenAngreifenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Angreifen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
private
   
   WenAngreifen : SpeziesDatentypen.Spezies_Enum;
   Ziel : SpeziesDatentypen.Spezies_Enum;
   
   KoordinatenFeind : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   
   
   function ZielErmitteln
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Spezies_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIEinheitFestlegenAngreifenLogik;
