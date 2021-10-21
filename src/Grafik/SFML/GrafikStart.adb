pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with GlobaleVariablen;
with SystemDatentypen;

with GrafikEinstellungen;
with GrafikAllgemein;
with GrafikFenster;

package body GrafikStart is

   procedure FensterErzeugen
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return;
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            GrafikEinstellungen.Fenster := Sf.Graphics.RenderWindow.createUnicode (mode  => GrafikEinstellungen.Modus,
                                                                                   title => Name);
      end case;

      if
        GrafikEinstellungen.Fenster = null
      then
         raise Program_Error;

      else
         Sf.Graphics.RenderWindow.setMouseCursor (renderWindow => GrafikEinstellungen.Fenster,
                                                  cursor       => GrafikEinstellungen.MausZeiger);
         -- Woanders hinschieben? Anders gestalten? Mit Werten auf Basis der Fensterabmessungen.
         Sf.Graphics.RenderWindow.Mouse.setPosition (position   => (100, 100),
                                                     relativeTo => GrafikEinstellungen.Fenster);
         Sf.Graphics.RenderWindow.setFramerateLimit (renderWindow => GrafikEinstellungen.Fenster,
                                                     limit        => GrafikEinstellungen.MaximaleBilderrate);
         
         GrafikAllgemein.AllgemeinesFestlegen;
         GrafikFenster.FensterFarbe;
      end if;
      
   end FensterErzeugen;
   
   
   
   procedure FensterEntfernen
   is begin
      
      Sf.Graphics.RenderWindow.destroy (renderWindow => GrafikEinstellungen.Fenster);
      
   end FensterEntfernen;

end GrafikStart;
