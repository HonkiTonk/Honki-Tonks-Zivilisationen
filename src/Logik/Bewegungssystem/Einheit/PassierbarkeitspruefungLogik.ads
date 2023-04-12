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
   use type KartenDatentypen.Kartenfeld;
   
   function PassierbarkeitPrüfenNummer
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function PassierbarkeitPrüfenID
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StadtBerücksichtigenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function RichtigeUmgebungVorhanden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
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
      
   IDEinheit : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   StadtNummer : StadtDatentypen.MaximaleStädteMitNullWert;
   StadtVorhanden : StadtDatentypen.MaximaleStädteMitNullWert;
   
   Stadtumgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Ekropaumgebung : KartenRecords.AchsenKartenfeldNaturalRecord;
   StadtKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   
   
   function IstNichtPassierbar
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
     
   function IstPassierbar
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StadtBerücksichtigenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end PassierbarkeitspruefungLogik;
