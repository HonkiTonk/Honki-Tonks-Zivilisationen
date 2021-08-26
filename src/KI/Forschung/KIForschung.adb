pragma SPARK_Mode (On);

with ForschungsDatenbank;

with ForschungAllgemein;

package body KIForschung is

   procedure Forschung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt
      is
         when 0 =>      
            ForschungSchleife:
            for TechnologieSchleifenwert in ForschungsDatenbank.ForschungListeArray'Range (2) loop
               
               case
                 ForschungAllgemein.ForschungAnforderungErfüllt (RasseExtern       => RasseExtern,
                                                                  ForschungIDExtern => TechnologieSchleifenwert)
               is
                  when True =>
                     GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt := TechnologieSchleifenwert;
                     GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := 0;
                     ForschungAllgemein.ForschungZeit (RasseExtern => RasseExtern);
                     return;
                     
                  when False =>
                     null;
               end case;
               
            end loop ForschungSchleife;
            
         when others =>
            null;
      end case;
      
   end Forschung;

end KIForschung;
