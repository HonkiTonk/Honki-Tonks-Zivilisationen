pragma SPARK_Mode (On);

with Karten;

package body KarteneigenschaftSuchen is

   function KartengrundEinheitSuchen
     (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund
   is begin
      
      return 1;
      
   end KartengrundEinheitSuchen;

end KarteneigenschaftSuchen;
