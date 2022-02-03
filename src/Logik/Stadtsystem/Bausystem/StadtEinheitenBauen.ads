pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenRecords;
with EinheitStadtDatentypen;
with SystemKonstanten;

package StadtEinheitenBauen is

   procedure EinheitFertiggestellt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
private
    
   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
      
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure PlatzErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure EinheitPlatzieren
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);

end StadtEinheitenBauen;
