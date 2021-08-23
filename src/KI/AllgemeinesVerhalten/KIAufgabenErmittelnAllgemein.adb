pragma SPARK_Mode (On);

with LeseEinheitenGebaut, LeseEinheitenDatenbank;

package body KIAufgabenErmittelnAllgemein is
   
   function SichHeilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
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
                                                       IDExtern    => EinheitID) / 3 * 2
      then
         return 3;
         
      elsif
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        > LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitID) / 2
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
     return Natural
   is begin
      
      return 0;
      
   end SichVerbessern;
   
   

   function NichtsTun
     return Natural
   is begin
      
      return 1;
      
   end NichtsTun;

end KIAufgabenErmittelnAllgemein;
