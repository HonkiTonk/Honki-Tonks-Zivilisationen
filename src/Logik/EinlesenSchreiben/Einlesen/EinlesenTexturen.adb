pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.Texture;

with EingeleseneTexturenSFML;
with Fehler;

package body EinlesenTexturen is
   
   procedure EinlesenTexturen
   is begin
      
      null;
      
      -- EinlesenHintergrundMenüs;
      EinlesenKartenfelder;
      
   end EinlesenTexturen;
   
   
   
   procedure EinlesenHintergrundMenüs
   is begin
      
      HintergrundSchleife:
      for HintergrundSchleifenwert in EingeleseneTexturenSFML.Hintergrund'Range loop
         
         case
           HintergrundSchleifenwert
         is
            when 1 =>
               EingeleseneTexturenSFML.Hintergrund (HintergrundSchleifenwert) := Sf.Graphics.Texture.createFromFile (filename => "Grafik/Hintergrund/Hintergrund" & HintergrundSchleifenwert'Image & ".png");
               
            when 2 =>
               EingeleseneTexturenSFML.Hintergrund (HintergrundSchleifenwert) := Sf.Graphics.Texture.createFromFile (filename => "Grafik/Hintergrund/Hintergrund" & HintergrundSchleifenwert'Image & ".png");
         end case;
         
         if
           EingeleseneTexturenSFML.Hintergrund (HintergrundSchleifenwert) = null
         then
            Fehler.GrafikStopp (FehlermeldungExtern => "EinlesenTexturen.EinlesenHintergrundMenüs - EingeleseneTexturen.Hintergrund (HintergrundSchleifenwert) = null");
            
         else
            null;
         end if;
         
      end loop HintergrundSchleife;
      
   end EinlesenHintergrundMenüs;
   
   
   
   procedure EinlesenKartenfelder
   is begin
      
      EingeleseneTexturenSFML.KartenfelderAccess := Sf.Graphics.Texture.createFromFile (filename => "Grafik/1.png");
         
      if
        EingeleseneTexturenSFML.KartenfelderAccess = null
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "EinlesenTexturen.EinlesenHintergrundMenüs - EingeleseneTexturen.Kartenfelder = null");
            
      else
         null;
      end if;
      
   end EinlesenKartenfelder;
   
end EinlesenTexturen;
