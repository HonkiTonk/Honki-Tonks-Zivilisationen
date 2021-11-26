pragma SPARK_Mode (On);

-- with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf; use Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Font;
-- with Sf.Graphics.Text;
with Sf.Window.Cursor;

with GrafikEinstellungen;
with GrafikStartEnde;

package body GrafikAllgemein is
      
   procedure FensterAnpassen
   is begin
            
      GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite := Sf.Graphics.RenderWindow.getSize (renderWindow => GrafikEinstellungen.Fenster).x;
      GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe := Sf.Graphics.RenderWindow.getSize (renderWindow => GrafikEinstellungen.Fenster).y;
      
      Sf.Graphics.View.setSize (view => NeueAuflösungAccess,
                                size => (Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite), Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe)));
      Sf.Graphics.View.setCenter (view   => NeueAuflösungAccess,
                                  center => (Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite) / 2.00, Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe) / 2.00));
      
      Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungen.Fenster,
                                        view         => NeueAuflösungAccess);
      
   end FensterAnpassen;
   
   
   
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
      
      GrafikEinstellungen.MausPosition := (1, 1);
      MauszeigerPositionFestlegen (PositionExtern => (GrafikEinstellungen.MausPosition));
      
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
      
      -- GrafikEinstellungen.TextStandard := Sf.Graphics.Text.create;
      
      -- Sf.Graphics.Text.setFont (text => GrafikEinstellungen.TextStandard,
       --                         font => GrafikEinstellungen.Schriftart);
      -- Sf.Graphics.Text.setCharacterSize (text => GrafikEinstellungen.TextStandard,
      --                                   size => GrafikEinstellungen.FensterEinstellungen.Schriftgröße);
      -- Sf.Graphics.Text.setColor (text  => GrafikEinstellungen.TextStandard,
      --                           color => (255, 0, 0, 255));
     -- Sf.Graphics.Text.setStyle (text  => GrafikEinstellungen.TextStandard,
       --                           style => 0);
       
      null;
      
   end TextAllgemeinFestlegen;
   
   
   
   procedure TextDateiZeichnen
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      WelcheZeileExtern : in Positive)
   is begin
      
      -- Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.TextStandard,
     --                                     str  => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), WelcheZeileExtern)));
     -- Sf.Graphics.Text.setPosition (text     => GrafikEinstellungen.TextStandard,
      --                              position => PositionExtern);
      -- Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
     --                                   text         => GrafikEinstellungen.TextStandard);
       
      null;
      
   end TextDateiZeichnen;
   
   
   
   procedure TextZeichnen
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      TextExtern : in Wide_Wide_String)
   is begin
      
     -- Sf.Graphics.Text.setUnicodeString (text => GrafikEinstellungen.TextStandard,
      --                                   str  => TextExtern);
     -- Sf.Graphics.Text.setPosition (text     => GrafikEinstellungen.TextStandard,
      --                              position => PositionExtern);
     -- Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
     --                                   text         => GrafikEinstellungen.TextStandard);
       
      null;
      
   end TextZeichnen;

end GrafikAllgemein;
