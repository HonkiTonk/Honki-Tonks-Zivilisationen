with TastenbelegungDatentypen;

with LeseAllgemeines;
with SchreibeGrafiktask;

with TasteneingabeLogik;

package body AbspannLogik is

   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Hintergrund_Outro_Enum)
   is begin
      
      case
        AbspannExtern
      is
         when GrafikDatentypen.Planetenvernichtung_Enum =>
            SchreibeGrafiktask.AktiveSpezies (SpeziesExtern => LeseAllgemeines.PlanetVernichtet);
            
         when others =>
            null;
      end case;
      
      SchreibeGrafiktask.Abspann (AbspannExtern => AbspannExtern);
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Abspann_Enum);
      
      AbspannSchleife:
      loop
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum | TastenbelegungDatentypen.Abwählen_Enum =>
               exit AbspannSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AbspannSchleife;
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Pause_Enum);
      SchreibeGrafiktask.Abspann (AbspannExtern => GrafikDatentypen.Leer_Enum);
      
   end Abspann;

end AbspannLogik;
