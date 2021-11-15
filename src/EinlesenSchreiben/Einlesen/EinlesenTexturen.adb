pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.Texture;

with EingeleseneTexturen;

package body EinlesenTexturen is
   
   procedure EinlesenTexturen
   is begin
      
      EinlesenHintergrundMenüs;
      EinlesenKartenfelder;
      
   end EinlesenTexturen;
   
   
   
   procedure EinlesenHintergrundMenüs
   is begin
      
      HintergrundSchleife:
      for HintergrundSchleifenwert in EingeleseneTexturen.Hintergrund'Range loop
         
         case
           HintergrundSchleifenwert
         is
            when 1 =>
               EingeleseneTexturen.Hintergrund (HintergrundSchleifenwert) := Sf.Graphics.Texture.createFromFile (filename => "Grafik/Hintergrund/Hintergrund" & HintergrundSchleifenwert'Image & ".png");
               
            when 2 =>
               EingeleseneTexturen.Hintergrund (HintergrundSchleifenwert) := Sf.Graphics.Texture.createFromFile (filename => "Grafik/Hintergrund/Hintergrund" & HintergrundSchleifenwert'Image & ".png");
         end case;
         
         if
           EingeleseneTexturen.Hintergrund (HintergrundSchleifenwert) = null
         then
            raise Program_Error;
            
         else
            null;
         end if;
         
      end loop HintergrundSchleife;
      
   end EinlesenHintergrundMenüs;
   
   
   
   procedure EinlesenKartenfelder
   is begin
      
      EingeleseneTexturen.Kartenfelder := Sf.Graphics.Texture.createFromFile (filename => "Grafik/Kartenfelder.png");
         
      if
        EingeleseneTexturen.Kartenfelder = null
      then
         raise Program_Error;
            
      else
         null;
      end if;
      
   end EinlesenKartenfelder;
   
end EinlesenTexturen;
