with SpeziesDatentypen;
with KartenDatentypen;
with EinheitenKonstanten;
with EinheitenRecords;
with KartenRecords;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package KIBewegungsbewertungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   function PositionsbewertungEinheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeueKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function PositionsbewertungKoordinaten
     (ZielkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 ZielkoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 ZielkoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 NeueKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeueKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
   
   BewertungEbene : KartenDatentypen.SenkrechteNatural;
   BewertungSenkrechte : KartenDatentypen.SenkrechteNatural;
   BewertungWaagerechte : KartenDatentypen.WaagerechteNatural;
   
   Zielkoordinaten : KartenRecords.KartenfeldNaturalRecord;
   
end KIBewegungsbewertungLogik;
