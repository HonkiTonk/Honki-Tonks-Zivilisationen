pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;

with InteraktionMusiktask;

package body Musik is

   procedure Musik
   is begin
      
      MusikSchleife:
      loop
         
         case
           InteraktionMusiktask.AktuelleMusik
         is
            when SystemDatentypen.Musik_SFML =>
               delay SystemKonstanten.WartezeitSound;
               
            when SystemDatentypen.Musik_Ende =>
               exit MusikSchleife;
         end case;
         
      end loop MusikSchleife;
      
   end Musik;

end Musik;
