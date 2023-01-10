with SpeziesDatentypen;
with EinheitenDatentypen;
with KartenDatentypen;
with KartenRecords;
with EinheitenKonstanten;
with EinheitenRecords;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package TransporterSuchenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   function KoordinatenTransporterMitSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function EinheitAufTransporterSuchen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return EinheitenDatentypen.Transportplätze
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => TransporterExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 TransporterExtern.Nummer > 0
              );

   function HatTransporterLadung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer > 0
              );
   
   function FreierPlatz
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.Transportplätze
     with
       Pre => (
                 TransporterExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => TransporterExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   Transporterkapazität : EinheitenDatentypen.Transportplätze;

end TransporterSuchenLogik;
