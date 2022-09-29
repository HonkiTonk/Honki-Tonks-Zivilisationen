pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

package body EinheitenAllgemeinesLogik is

   function Kampfeinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        LeseEinheitenDatenbank.Einheitenart (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitenDatentypen.Einheitenart_Kampf_Enum'Range =>
            return True;
            
         when EinheitenDatentypen.Arbeiter_Enum | EinheitenDatentypen.PZB_Enum'Range | EinheitenDatentypen.Cheat_Enum =>
            return False;
            
         when EinheitenDatentypen.Leer_Einheitart_Enum =>
            return False;
      end case;
      
   end Kampfeinheit;
   
end EinheitenAllgemeinesLogik;
