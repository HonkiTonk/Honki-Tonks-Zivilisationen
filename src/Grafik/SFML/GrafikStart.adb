pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with GrafikEinstellungen;

package body GrafikStart is

   function FensterErzeugen
     return Boolean
   is begin
      
      GrafikEinstellungen.Fenster := Sf.Graphics.RenderWindow.createUnicode (mode  => GrafikEinstellungen.Modus,
                                                                             title => Name);

      if
        GrafikEinstellungen.Fenster = null
      then
         return False;

      else
         Sf.Graphics.RenderWindow.setMouseCursor (renderWindow => GrafikEinstellungen.Fenster,
                                                  cursor       => GrafikEinstellungen.Zeiger);
         -- Woanders hinschieben? Anders gestalten? Mit Werten auf Basis der Fensterabmessungen.
         Sf.Graphics.RenderWindow.Mouse.setPosition (position   => (100, 100),
                                                     relativeTo => GrafikEinstellungen.Fenster);
         Sf.Graphics.RenderWindow.setFramerateLimit (renderWindow => GrafikEinstellungen.Fenster,
                                                     limit        => GrafikEinstellungen.MaximaleBilderrate);
         return True;
      end if;
      
   end FensterErzeugen;
   
   
   
   procedure FensterEntfernen
   is begin
      
      Sf.Graphics.RenderWindow.destroy (renderWindow => GrafikEinstellungen.Fenster);
      
   end FensterEntfernen;

end GrafikStart;
