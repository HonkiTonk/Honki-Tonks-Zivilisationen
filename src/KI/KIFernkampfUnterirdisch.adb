pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KIFernkampfUnterirdisch is

   procedure KIFernkampfUnterirdisch
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             AufgabeExtern            => KIDatentypen.Erkunden);
      
   end KIFernkampfUnterirdisch;

end KIFernkampfUnterirdisch;
