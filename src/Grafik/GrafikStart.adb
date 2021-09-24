pragma SPARK_Mode (On);

with Sf.Graphics.RenderWindow;

with GrafikEinstellungen;

package body GrafikStart is

   function FensterErzeugen
     return Boolean
   is begin
      
      Fenster := Sf.Graphics.RenderWindow.create (mode  => GrafikEinstellungen.Modus,
                                                  title => "Name des Spiels");

      if
        Fenster = null
      then
         return False;

      else
         Sf.Graphics.RenderWindow.setMouseCursor (renderWindow => Fenster,
                                                  cursor       => GrafikEinstellungen.Zeiger);
         Sf.Graphics.RenderWindow.setFramerateLimit (renderWindow => Fenster,
                                                     limit        => GrafikEinstellungen.MaximaleBilderrate);
         return True;
      end if;
      
   end FensterErzeugen;
   
   
   
   procedure FensterEntfernen
   is begin
      
      Sf.Graphics.RenderWindow.destroy (renderWindow => Fenster);
      
   end FensterEntfernen;

end GrafikStart;
