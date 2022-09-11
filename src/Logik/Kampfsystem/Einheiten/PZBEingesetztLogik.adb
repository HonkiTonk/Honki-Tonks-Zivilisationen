pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with EinheitenErzeugenEntfernenLogik;

package body PZBEingesetztLogik is

   function PZBEingesetzt
     (EinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitExtern))
      is
         when EinheitenDatentypen.PZB_Enum =>
            SpielVariablen.Allgemeines.PlanetVernichtet := EinheitExtern.Rasse;
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => EinheitExtern);
            
         when others =>
            return False;
      end case;
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         SpielVariablen.Rassenbelegung (RasseSchleifenwert).Besiegt := True;
         
      end loop RassenSchleife;
      
      return True;
      
   end PZBEingesetzt;

end PZBEingesetztLogik;
