pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;
with KartenRecords;
with EinheitStadtDatentypen;
with SystemKonstanten;

package KIFeindlicheEinheitSuchen is

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FeindExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (FeindExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
   
private
   
   FeindlicheEinheit : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

end KIFeindlicheEinheitSuchen;
