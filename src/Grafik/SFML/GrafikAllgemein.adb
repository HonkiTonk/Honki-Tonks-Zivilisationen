pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf; use Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Font;
with Sf.Graphics.Text;
with Sf.Window.Cursor;

with GrafikEinstellungen;
with GrafikStartEnde;
with Fehler;

package body GrafikAllgemein is

   -- Immer erster Grafikaufruf.
   procedure FensterLeeren
   is begin
      
      Sf.Graphics.RenderWindow.clear (renderWindow => GrafikEinstellungen.Fenster,
                                      color        => Sf.Graphics.Color.sfBlack);
      
   end FensterLeeren;
   -- Immer erster Grafikaufruf.
   
   
   
   procedure FensterAnpassen
   is begin
            
      GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite := Sf.Graphics.RenderWindow.getSize (renderWindow => GrafikEinstellungen.Fenster).x;
      GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe := Sf.Graphics.RenderWindow.getSize (renderWindow => GrafikEinstellungen.Fenster).y;
      
      Sf.Graphics.View.setSize (view => NeueAuflösungZugriff,
                                size => (Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite), Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe)));
      Sf.Graphics.View.setCenter (view   => NeueAuflösungZugriff,
                                  center => (Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite) / 2.00, Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe) / 2.00));
      
      Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungen.Fenster,
                                        view         => NeueAuflösungZugriff);
      
   end FensterAnpassen;
   
   
   
   -- Immer letzter Grafikaufruf.
   procedure FensterAnzeigen
   is begin
      
      Sf.Graphics.RenderWindow.display (renderWindow => GrafikEinstellungen.Fenster);
      
   end FensterAnzeigen;
   -- Immer letzter Grafikaufruf.
   
   
   
   procedure FensterAuflösungÄndern
     (NeueAuflösungExtern : in Sf.System.Vector2.sfVector2u)
   is begin
      
      GrafikEinstellungen.FensterEinstellungen.FensterBreite := NeueAuflösungExtern.x;
      GrafikEinstellungen.FensterEinstellungen.FensterHöhe := NeueAuflösungExtern.y;
      
      GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite := NeueAuflösungExtern.x;
      GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe := NeueAuflösungExtern.y;
      
      GrafikStartEnde.FensterEntfernen;
      
      GrafikStartEnde.FensterErzeugen;
      
   end FensterAuflösungÄndern;
   
   
   
   procedure BildrateÄndern
     (NeueBildrateExtern : in Sf.sfUint32)
   is begin
      
      Sf.Graphics.RenderWindow.setFramerateLimit (renderWindow => GrafikEinstellungen.Fenster,
                                                  limit        => NeueBildrateExtern);
      
   end BildrateÄndern;
   
   
   
   procedure MauszeigerFestlegen
   is begin
      
      GrafikEinstellungen.Maus := Sf.Window.Cursor.createFromSystem (cursorType => GrafikEinstellungen.FensterEinstellungen.MausZeiger);
      Sf.Graphics.RenderWindow.setMouseCursor (renderWindow => GrafikEinstellungen.Fenster,
                                               cursor       => GrafikEinstellungen.Maus);
      
      MauszeigerPositionFestlegen (PositionExtern => (0, 0));
      
   end MauszeigerFestlegen;
   
   
   
   procedure MauszeigerPositionFestlegen
     (PositionExtern : in Sf.System.Vector2.sfVector2i)
   is begin
      
      if
        PositionExtern.x <= 0
        or
          PositionExtern.y <= 0
      then
         Sf.Graphics.RenderWindow.Mouse.setPosition (position   => (1, 1),
                                                     relativeTo => GrafikEinstellungen.Fenster);
         
      else
         Sf.Graphics.RenderWindow.Mouse.setPosition (position   => PositionExtern,
                                                     relativeTo => GrafikEinstellungen.Fenster);
      end if;
      
   end MauszeigerPositionFestlegen;
   
   
   
   procedure SchriftartFestlegen
   is begin
      
      GrafikEinstellungen.Schriftart := Sf.Graphics.Font.createFromFile (filename => "Grafik/OregonLdo-d9q7.ttf");
      
   end SchriftartFestlegen;
   
   
   
   procedure TextAllgemeinFestlegen
   is begin
      
      GrafikEinstellungen.TextStandard := Sf.Graphics.Text.create;
      
      Sf.Graphics.Text.setFont (text => GrafikEinstellungen.TextStandard,
                                font => GrafikEinstellungen.Schriftart);
      Sf.Graphics.Text.setCharacterSize (text => GrafikEinstellungen.TextStandard,
                                         size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      Sf.Graphics.Text.setColor (text  => GrafikEinstellungen.TextStandard,
                                 color => (255, 0, 0, 255));
      Sf.Graphics.Text.setStyle (text  => GrafikEinstellungen.TextStandard,
                                 style => 0);
      
   end TextAllgemeinFestlegen;
   
   
   
   procedure TextDateiZeichnen
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      WelcheZeileExtern : in Positive)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.TextStandard,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), WelcheZeileExtern)));
      Sf.Graphics.Text.setPosition (text     => GrafikEinstellungen.TextStandard,
                                    position => PositionExtern);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => GrafikEinstellungen.TextStandard);
      
   end TextDateiZeichnen;
   
   
   
   procedure TextZeichnen
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      TextExtern : in Wide_Wide_String)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.TextStandard,
                                         str  => TextExtern);
      Sf.Graphics.Text.setPosition (text     => GrafikEinstellungen.TextStandard,
                                    position => PositionExtern);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => GrafikEinstellungen.TextStandard);
      
   end TextZeichnen;
   
   
   
   procedure RechteckZeichnen
     (AbmessungExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      PositionPrüfen (PositionExtern => PositionExtern);
      
      if
        AbmessungExtern.y = 0.00
        or
          AbmessungExtern.x = 0.00
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "GrafikAllgemein.RechteckZeichnen - Rechteck ist ein Strich");
         
      elsif
        AbmessungExtern.y > Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe)
        or
          AbmessungExtern.x > Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite)
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "GrafikAllgemein.RechteckZeichnen - Rechteck ist größer als das Fenster");
         
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
         Fehler.GrafikStopp (FehlermeldungExtern => "GrafikAllgemein.KreisZeichnen - RadiusExtern = 0.00");
         
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
         Fehler.GrafikStopp (FehlermeldungExtern => "GrafikAllgemein.PolygonZeichnen - RadiusExtern = 0.00");
         
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
        PositionExtern.y < 0.00
        or
          PositionExtern.x < 0.00
          or
            PositionExtern.y >= Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe)
        or
          PositionExtern.x >= Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite)
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "GrafikAllgemein.PositionPrüfen - Ein Objekt wurde außerhalb des Fensters positioniert.");
         
      else
         null;
      end if;
      
   end PositionPrüfen;

end GrafikAllgemein;
