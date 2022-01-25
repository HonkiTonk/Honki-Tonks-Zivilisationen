pragma SPARK_Mode (On);

with SystemDatentypen;
with SystemKonstanten;
with GlobaleVariablen;

with InteraktionLogiktask;
with Musik;

package body StartMusik is

   procedure StartMusik
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            return;
            
         when others =>
            null;
      end case;
      
      EinlesenAbwartenSchleife:
      while InteraktionLogiktask.EinlesenAbgeschlossen = False loop
         
         delay SystemKonstanten.WartezeitMusik;
         
      end loop EinlesenAbwartenSchleife;
      
      Musik.Musik;
      
   end StartMusik;

end StartMusik;
