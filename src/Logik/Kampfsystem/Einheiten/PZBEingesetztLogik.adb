pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with EinheitenErzeugenEntfernenLogik;

-- Hier noch das Zeitlimit für große Karten einbauen. äöü
package body PZBEingesetztLogik is

   function PZBEingesetzt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitenDatentypen.PZB_Enum =>
            SpielVariablen.Allgemeines.PlanetVernichtet := EinheitRasseNummerExtern.Rasse;
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
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
