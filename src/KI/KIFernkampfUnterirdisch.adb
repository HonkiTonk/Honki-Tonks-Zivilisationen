pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KIFernkampfUnterirdisch is

   procedure KIFernkampfUnterirdisch (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe            => KIDatentypen.Erkunden);
      
   end KIFernkampfUnterirdisch;

end KIFernkampfUnterirdisch;
