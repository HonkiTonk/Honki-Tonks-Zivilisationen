pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KINahkampfUnterirdisch is

   procedure KINahkampfUnterirdisch (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe            => KIDatentypen.Erkunden);
      
   end KINahkampfUnterirdisch;

end KINahkampfUnterirdisch;
