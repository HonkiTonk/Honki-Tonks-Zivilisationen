pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen;

with ForschungenDatenbank;

with SchreibeWichtiges;
with LeseWichtiges;

with ForschungAllgemein;

package body KIForschung is

   procedure Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern)
      is
         when EinheitStadtDatentypen.ForschungIDMitNullWert'First =>
            NeuesForschungsprojekt (RasseExtern => RasseExtern);
            
         when others =>
            null;
      end case;
      
   end Forschung;
   
   
   
   procedure NeuesForschungsprojekt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      ForschungSchleife:
      for TechnologieSchleifenwert in ForschungenDatenbank.ForschungslisteArray'Range (2) loop
               
         case
           ForschungAllgemein.ForschungAnforderungErfüllt (RasseExtern       => RasseExtern,
                                                            ForschungIDExtern => TechnologieSchleifenwert)
         is
            when True =>
               SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                                    ForschungIDExtern => TechnologieSchleifenwert);
               return;
                     
            when False =>
               null;
         end case;
               
      end loop ForschungSchleife;
      
   end NeuesForschungsprojekt;

end KIForschung;
