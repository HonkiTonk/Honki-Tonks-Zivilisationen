pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KINahkampfUnterirdisch is

   procedure KINahkampfUnterirdisch
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             AufgabeExtern            => KIDatentypen.Erkunden);
      
   end KINahkampfUnterirdisch;

end KINahkampfUnterirdisch;
