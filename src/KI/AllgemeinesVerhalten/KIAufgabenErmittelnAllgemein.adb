pragma SPARK_Mode (On);

with LeseEinheitenGebaut, LeseEinheitenDatenbank, LeseWichtiges;

package body KIAufgabenErmittelnAllgemein is
   
   function SichHeilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        = LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitID)
      then
         return 0;
         
      elsif
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        > LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitID)
        / 3 * 2
      then
         return 3;
         
      elsif
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        > LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitID)
        / 2
      then
         return 5;
         
      elsif
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = 1
      then
         return 10;
         
      else
         return 8;
      end if;
      
   end SichHeilen;
   
   
   
   function SichVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      NotwendigeTechnologie := LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                        IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        NotwendigeTechnologie
      is
         when GlobaleDatentypen.EinheitenIDMitNullWert'First =>
            return 0;
            
         when others =>
            null;
      end case;
      
      if
        LeseWichtiges.Erforscht (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => NotwendigeTechnologie)
        = True
      then
         return 2;
            
      else
         return 0;
      end if;
      
   end SichVerbessern;
   
   

   function NichtsTun
     return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return 1;
      
   end NichtsTun;

end KIAufgabenErmittelnAllgemein;
