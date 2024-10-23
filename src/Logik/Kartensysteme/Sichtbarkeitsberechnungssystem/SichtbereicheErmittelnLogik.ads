with SpeziesDatentypen;
with EinheitenRecords;
with KartenDatentypen;
with KartenRecords;
with KartenKonstanten;
with EinheitenKonstanten;

private with EinheitenDatentypen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package SichtbereicheErmittelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function SichtweiteErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.SichtweitePositiveRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function SichtbarkeitBlockadeTesten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SenkrechteÄnderungExtern : in KartenDatentypen.SenkrechteUmgebungZwei;
      WaagerechteÄnderungExtern : in KartenDatentypen.WaagerechteUmgebungZwei;
      SichtweiteExtern : in KartenRecords.UmgebungDreiRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
              );

private
   
   EinheitID : EinheitenDatentypen.EinheitenID;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;
   
   KoordinatenEinheit : KartenRecords.KartenfeldNaturalRecord;
   KartenBlockadeWert : KartenRecords.KartenfeldNaturalRecord;
   
end SichtbereicheErmittelnLogik;
