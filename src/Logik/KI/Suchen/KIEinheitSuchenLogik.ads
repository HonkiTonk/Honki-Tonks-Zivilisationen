with RassenDatentypen;
with EinheitenRecords;
with KartenRecords;
with EinheitenKonstanten;

private with EinheitenDatentypen;
private with KartenDatentypen;

with LeseGrenzen;
with LeseRassenbelegung;

package KIEinheitSuchenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => FeindExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
   function TransporterSuchen
     return Integer;
   
private
   
   FeindlicheEinheit : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   UmgebungPrüfen : KartenDatentypen.KartenfeldNatural;
   BereitsGeprüft : KartenDatentypen.KartenfeldNatural;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Einheitenkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitSuchenLogik;
