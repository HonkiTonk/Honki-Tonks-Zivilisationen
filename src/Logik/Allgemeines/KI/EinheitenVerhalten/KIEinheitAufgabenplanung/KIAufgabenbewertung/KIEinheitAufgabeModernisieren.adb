pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with LeseEinheitenDatenbank;
with LeseWichtiges;
with LeseEinheitenGebaut;

package body KIEinheitAufgabeModernisieren is

   function SichVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      ----------------------- Das hier ging möglicherweise beim auseinander Bauen von den ganzen IDs kaputt.
      NotwendigeTechnologie := ForschungenDatentypen.ForschungIDMitNullWert (LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                      IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      case
        NotwendigeTechnologie
      is
         when ForschungenDatentypen.ForschungIDMitNullWert'First =>
            return 0;
            
         when others =>
            null;
      end case;
      
      if
        LeseWichtiges.Erforscht (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => NotwendigeTechnologie)
        = True
      then
         return 3;
            
      else
         return 0;
      end if;
      
   end SichVerbessern;

end KIEinheitAufgabeModernisieren;
