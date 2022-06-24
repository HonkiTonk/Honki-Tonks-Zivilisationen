pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

package body EinheitenAllgemeines is

   function Kampfeinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitenDatentypen.Fernkämpfer_Enum | EinheitenDatentypen.Nahkämpfer_Enum | EinheitenDatentypen.Beides_Enum =>
            return True;
            
         when EinheitenDatentypen.Leer_Einheitart_Enum | EinheitenDatentypen.Arbeiter_Enum | EinheitenDatentypen.Sonstiges_Enum | EinheitenDatentypen.Cheat_Enum =>
            return False;
      end case;
      
   end Kampfeinheit;
   
end EinheitenAllgemeines;
