pragma SPARK_Mode (On);

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;
with Sf.Graphics.Font;
with Sf.Graphics.Text;

with GrafikEinstellungen;

package body GrafikAllgemein is

   -- Immer erster Grafikaufruf.
   procedure FensterLeeren
   is begin
      
      Sf.Graphics.RenderWindow.clear (renderWindow => GrafikEinstellungen.Fenster,
                                      color        => Sf.Graphics.Color.sfBlack);
      
   end FensterLeeren;
   -- Immer erster Grafikaufruf.
   
   
   
   -- Immer letzter Grafikaufruf.
   procedure FensterAnzeigen
   is begin
      
      Sf.Graphics.RenderWindow.display (renderWindow => GrafikEinstellungen.Fenster);
      
   end FensterAnzeigen;
   -- Immer letzter Grafikaufruf.
   
   
   
   procedure AllgemeinesFestlegen
   is begin
      
      null;
      
   end AllgemeinesFestlegen;
   
   
   
   procedure SchriftartFestlegen
   is begin
      
      GrafikEinstellungen.Schriftart := Sf.Graphics.Font.createFromFile (filename => "Grafik/OregonLdo-d9q7.ttf");
      
   end SchriftartFestlegen;
   
   
   
   procedure TextAllgemeinFestlegen
   is begin
      
      GrafikEinstellungen.Schriftgröße := 24;
      
      Sf.Graphics.Text.setFont (text => GrafikEinstellungen.Text,
                                font => GrafikEinstellungen.Schriftart);
      Sf.Graphics.Text.setCharacterSize (text => GrafikEinstellungen.Text,
                                         size => GrafikEinstellungen.Schriftgröße);
      Sf.Graphics.Text.setColor (text  => GrafikEinstellungen.Text,
                                 color => (255, 0, 0, 255));
      Sf.Graphics.Text.setStyle (text  => GrafikEinstellungen.Text,
                                 style => 0);
      
   end TextAllgemeinFestlegen;

end GrafikAllgemein;
