pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen, KartenRecords;
use GlobaleDatentypen;

package GebaeudeRichtigeUmgebung is

   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GebäudeIDExtern : in GlobaleDatentypen.GebäudeID)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   function UmgebungPrüfen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GebäudeIDExtern : in GlobaleDatentypen.GebäudeID)
      return Boolean;

end GebaeudeRichtigeUmgebung;
