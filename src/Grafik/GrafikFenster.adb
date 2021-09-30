pragma SPARK_Mode (On);

with Sf.Graphics.RenderWindow, Sf.Graphics.Texture, Sf.Graphics.Text;

with GrafikEinstellungen, GrafikAllgemein;

package body GrafikFenster is

   procedure FensterFarbe
   is begin
      
      GrafikAllgemein.FensterLeeren;
      TexturAnzeigen;
      GrafikAllgemein.SchriftartFestlegen;
      TextAnzeigen;
      GrafikAllgemein.FensterAnzeigen;
      
   end FensterFarbe;
   
   
   
   procedure TexturAnzeigen
   is begin
      
      Hintergrundbild := Sf.Graphics.Texture.createFromFile (filename => "Grafik/TestGrafik.png");
      Sf.Graphics.Sprite.setTexture (sprite    => Sprite,
                                     texture   => Hintergrundbild);
      Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungen.Fenster,
                                           object       => Sprite);
      
   end TexturAnzeigen;
   
   
   
   procedure TextAnzeigen
   is begin
      
      GrafikAllgemein.TextAllgemeinFestlegen;
      
      Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.Text,
                                         str  => "Test!");
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => GrafikEinstellungen.Text);
      
   end TextAnzeigen;

end GrafikFenster;
