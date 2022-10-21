pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with LeseEinheitenGebaut;

with Vergleiche;

with KIKonstanten;

package body KIEinheitAufgabePlatzMachenLogik is

   function PlatzMachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      BlockiertSchleife:
      for BlockiertSchleifenwert in SpielVariablen.EinheitenGebautArray'Range (2) loop
         
         case
           Vergleiche.Koordinatenvergleich (KoordinateEinsExtern  => EinheitenKoordinaten,
                                            KoordinatenZweiExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, BlockiertSchleifenwert)))
         is
            when True =>
               return KIKonstanten.PlatzFreiMachen;
               
            when False =>
               null;
         end case;
         
      end loop BlockiertSchleife;
      
      return KIKonstanten.UnmöglichAufgabenbewertung;
      
   end PlatzMachen;

end KIEinheitAufgabePlatzMachenLogik;
