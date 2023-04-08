with SpeziesDatentypen;
with EinheitenKonstanten;
with EinheitenRecords;

private with KartenRecords;
private with StadtDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KIEinheitFestlegenSiedelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function StadtBauen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

private

   AnzahlStädte : StadtDatentypen.MaximaleStädteMitNullWert;

   NeueStadtKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitFestlegenSiedelnLogik;
