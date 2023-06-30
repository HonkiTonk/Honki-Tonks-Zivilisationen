with TastenbelegungDatentypen;

with LeseAllgemeines;

with Grafiktask;
with TasteneingabeLogik;

package body AbspannLogik is

   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Abspannhintergrund_Enum)
   is begin
      
      case
        AbspannExtern
      is
         when GrafikDatentypen.Planet_Vernichtet_Enum =>
            Grafiktask.Aktuelles.AktuelleSpezies := LeseAllgemeines.PlanetVernichtet;
            
         when others =>
            null;
      end case;
      
      Grafiktask.Grafik.Abspannart := AbspannExtern;
      Grafiktask.Grafik.AktuelleDarstellung := GrafikDatentypen.Abspann_Enum;
      
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
      
      Grafiktask.Grafik.AktuelleDarstellung := GrafikDatentypen.Pause_Enum;
      Grafiktask.Grafik.Abspannart := GrafikDatentypen.Leer_Hintergrund_Enum;
      
   end Abspann;

end AbspannLogik;
