pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;

package KarteneigenschaftSuchen is

   function KartengrundEinheitSuchen
     (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KartenGrund;

end KarteneigenschaftSuchen;
