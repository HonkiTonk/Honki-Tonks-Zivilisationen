pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with EinheitenRecords;
with KartenRecords;
with EinheitenDatentypen;
with SpielVariablen;

package KIFeindlicheEinheitSuchen is

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (FeindExtern) /= RassenDatentypen.Leer_Spieler_Enum
          and
            EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum);
   
private
   
   FeindlicheEinheit : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIFeindlicheEinheitSuchen;
