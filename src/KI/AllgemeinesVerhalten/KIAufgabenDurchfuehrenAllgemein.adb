pragma SPARK_Mode (On);

package body KIAufgabenDurchfuehrenAllgemein is

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if
        EinheitRasseNummerExtern.Platznummer = 0
      then
         null;
         
      else
         null;
      end if;
      
      return False;
      
   end EinheitVerbessern;

end KIAufgabenDurchfuehrenAllgemein;
