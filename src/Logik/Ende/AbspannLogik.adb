with TastenbelegungDatentypen;

with LeseAllgemeines;

with NachGrafiktask;
with TasteneingabeLogik;

package body AbspannLogik is

   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Abspann_Enum)
   is begin
      
      case
        AbspannExtern
      is
         when GrafikDatentypen.Planet_Vernichtet_Enum =>
            NachGrafiktask.AktuelleSpezies := LeseAllgemeines.PlanetVernichtet;
            
         when others =>
            null;
      end case;
      
      NachGrafiktask.Abspannart := AbspannExtern;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Abspann_Enum;
      
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
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      NachGrafiktask.Abspannart := GrafikDatentypen.Leer_Hintergrund_Enum;
      
   end Abspann;

end AbspannLogik;
