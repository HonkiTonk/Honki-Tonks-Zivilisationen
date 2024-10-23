with KartenDatentypen;
with SpeziesDatentypen;
with KartenRecords;
with EinheitenRecords;
with EinheitenDatentypen;
with StadtRecords;
with StadtKonstanten;
with EinheitenKonstanten;

private with StadtDatentypen;
private with KartenverbesserungDatentypen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package PassierbarkeitspruefungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   function PassierbarkeitPrüfenNummer
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 NeueKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeueKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function PassierbarkeitPrüfenID
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      StadtBerücksichtigenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 NeueKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeueKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function RichtigeUmgebungVorhanden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private
   
   Passierbar : Boolean;
   
   WegVorhanden : KartenverbesserungDatentypen.Weg_Enum;
      
   IDEinheit : EinheitenDatentypen.EinheitenID;
   
   StadtNummer : StadtDatentypen.Städtebereich;
   StadtVorhanden : StadtDatentypen.Städtebereich;
   
   Stadtumgebung : KartenRecords.UmgebungDreiRecord;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   Ekropaumgebung : KartenRecords.KartenfeldNaturalRecord;
   StadtKoordinaten : KartenRecords.KartenfeldNaturalRecord;
   
   
   
   function IstNichtPassierbar
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 NeueKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeueKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
     
   function IstPassierbar
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      StadtBerücksichtigenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 NeueKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeueKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end PassierbarkeitspruefungLogik;
