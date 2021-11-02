pragma SPARK_Mode (On);

with GrafikEinstellungen;

package body KarteInformationenSFML is

   procedure KarteInformationenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        RasseExtern
      is
         when SystemDatentypen.Menschen =>
            null;
            
         when others =>
            null;
      end case;
      
      FensterInformationen := (Float (GrafikEinstellungen.FensterBreite), Float (GrafikEinstellungen.FensterHöhe) * 0.20);
      
   end KarteInformationenSFML;

end KarteInformationenSFML;
