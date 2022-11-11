with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with KartenRecords;
with SpielVariablen;

private with EinheitenDatentypen;

package KIEinheitSuchenLogik is
   pragma Elaborate_Body;

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (FeindExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
   function TransporterSuchen
     return Integer;
   
private
   
   FeindlicheEinheit : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Einheitenkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitSuchenLogik;
