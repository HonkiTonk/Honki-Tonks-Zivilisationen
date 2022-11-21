with RassenDatentypen;
with EinheitenRecords;
with KartenRecords;
with SpielVariablen;

private with EinheitenDatentypen;
private with KartenDatentypen;

with LeseGrenzen;

package KIEinheitSuchenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (FeindExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
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
