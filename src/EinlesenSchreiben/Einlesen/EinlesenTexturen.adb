pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.Texture;

with EingeleseneTexturen;
with Fehler;

package body EinlesenTexturen is
   
   procedure EinlesenTexturen
   is begin
      
      null;
      
      -- EinlesenHintergrundMenüs;
      -- EinlesenKartenfelder;
      
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
            Fehler.GrafikStopp (FehlermeldungExtern => "EinlesenTexturen.EinlesenHintergrundMenüs - EingeleseneTexturen.Hintergrund (HintergrundSchleifenwert) = null");
            
         else
            null;
         end if;
         
      end loop HintergrundSchleife;
      
   end EinlesenHintergrundMenüs;
   
   
   
   procedure EinlesenKartenfelder
   is begin
      
      EingeleseneTexturen.KartenfelderAccess := Sf.Graphics.Texture.createFromFile (filename => "Grafik/Kartenfelder.png");
         
      if
        EingeleseneTexturen.KartenfelderAccess = null
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "EinlesenTexturen.EinlesenHintergrundMenüs - EingeleseneTexturen.Kartenfelder = null");
            
      else
         null;
      end if;
      
   end EinlesenKartenfelder;
   
end EinlesenTexturen;
