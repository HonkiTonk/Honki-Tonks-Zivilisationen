pragma SPARK_Mode (On);

with Sf.Graphics.RenderWindow;
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
   
   
   
   procedure RechteckZeichnen
     (AbmessungExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      PositionPrüfen (PositionExtern => PositionExtern);
      
      if
        AbmessungExtern.x = 0.00
        or
          AbmessungExtern.y = 0.00
      then
         raise Program_Error;
         
      else
         Sf.Graphics.RectangleShape.setSize (shape => Rechteck,
                                             size  => AbmessungExtern);
         Sf.Graphics.RectangleShape.setPosition (shape    => Rechteck,
                                                 position => PositionExtern);
         Sf.Graphics.RectangleShape.setFillColor (shape => Rechteck,
                                                  color => FarbeExtern);
         Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                      object       => Rechteck);
      end if;
      
   end RechteckZeichnen;
   
   
   
   procedure KreisZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      PositionPrüfen (PositionExtern => PositionExtern);
      
      if
        RadiusExtern = 0.00
      then
         raise Program_Error;
         
      else
         Sf.Graphics.CircleShape.setRadius (shape  => Kreis,
                                            radius => RadiusExtern);
         Sf.Graphics.CircleShape.setPosition (shape    => Kreis,
                                              position => PositionExtern);
         Sf.Graphics.CircleShape.setFillColor (shape => Kreis,
                                               color => FarbeExtern);
         Sf.Graphics.RenderWindow.drawCircleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                   object       => Kreis);
      end if;
      
   end KreisZeichnen;
   
   
   
   procedure PolygonZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      AnzahlEckenExtern : in Sf.sfSize_t;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      PositionPrüfen (PositionExtern => PositionExtern);
      
      if
        RadiusExtern = 0.00
      then
         raise Program_Error;
         
      else
         Sf.Graphics.CircleShape.setRadius (shape  => Polygon,
                                            radius => RadiusExtern);
         Sf.Graphics.CircleShape.setPointCount (shape => Polygon,
                                                count => AnzahlEckenExtern);
         Sf.Graphics.CircleShape.setPosition (shape    => Polygon,
                                              position => PositionExtern);
         Sf.Graphics.CircleShape.setFillColor (shape => Polygon,
                                               color => FarbeExtern);
         Sf.Graphics.RenderWindow.drawCircleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                   object       => Polygon);
      end if;
      
   end PolygonZeichnen;
   
   
   
   procedure PositionPrüfen
     (PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      if
        PositionExtern.x < 0.00
        or
          PositionExtern.y < 0.00
          or
            PositionExtern.x > Float (GrafikEinstellungen.FensterBreite)
        or
          PositionExtern.y > Float (GrafikEinstellungen.FensterHöhe)
      then
         raise Program_Error;
         
      else
         null;
      end if;
      
   end PositionPrüfen;

end GrafikAllgemein;
