with SpeziesDatentypen;
with EinheitenRecords;
with KartenRecords;
with EinheitenKonstanten;

private with EinheitenDatentypen;
private with KartenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KIEinheitSuchenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      FeindExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => FeindExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function TransporterSuchen
     return Integer;
   
private
   
   FeindlicheEinheit : EinheitenDatentypen.Einheitenbereich;
   
   SenkrechtePrüfen : KartenDatentypen.SenkrechtePositiv;
   SenkrechteGeprüft : KartenDatentypen.SenkrechteNatural;
   
   WaagerechtePrüfen : KartenDatentypen.WaagerechtePositiv;
   WaagerechteGeprüft : KartenDatentypen.WaagerechteNatural;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   Einheitenkoordinaten : KartenRecords.KartenfeldNaturalRecord;

end KIEinheitSuchenLogik;
