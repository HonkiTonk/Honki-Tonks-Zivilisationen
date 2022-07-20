pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Font;
with Sf.Window.Cursor;

with GrafikDatentypen;

with GrafikStartEndeSFML;
with GrafikEinstellungenSFML;
with NachGrafiktask;

package body GrafikAllgemeinSFML is
      
   procedure FensterAnpassen
   is begin
      
      case
        NachGrafiktask.FensterVerändert
      is
         when GrafikDatentypen.Auflösung_Verändert_Enum | GrafikDatentypen.Modus_Verändert_Enum =>
            GrafikStartEndeSFML.FensterEntfernen;
            GrafikStartEndeSFML.FensterErzeugen;
            GrafikEinstellungenSFML.AktuelleFensterAuflösung.x := Sf.Graphics.RenderWindow.getSize (renderWindow => GrafikEinstellungenSFML.FensterAccess).x;
            GrafikEinstellungenSFML.AktuelleFensterAuflösung.y := Sf.Graphics.RenderWindow.getSize (renderWindow => GrafikEinstellungenSFML.FensterAccess).y;
            
         when others =>
            GrafikEinstellungenSFML.AktuelleFensterAuflösung.x := Sf.Graphics.RenderWindow.getSize (renderWindow => GrafikEinstellungenSFML.FensterAccess).x;
            GrafikEinstellungenSFML.AktuelleFensterAuflösung.y := Sf.Graphics.RenderWindow.getSize (renderWindow => GrafikEinstellungenSFML.FensterAccess).y;
            
            Sf.Graphics.View.setSize (view => NeueAuflösungAccess,
                                      size => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y)));
            Sf.Graphics.View.setCenter (view   => NeueAuflösungAccess,
                                        center => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00));
      
            Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              view         => NeueAuflösungAccess);
      end case;
      
   end FensterAnpassen;
   
   
   
   procedure BildrateÄndern
   is begin
      
      Sf.Graphics.RenderWindow.setFramerateLimit (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  limit        => GrafikEinstellungenSFML.FensterEinstellungen.Bildrate);
      
   end BildrateÄndern;
   
   
   
   procedure MauszeigerFestlegen
   is begin
      
      GrafikEinstellungenSFML.MausAccess := Sf.Window.Cursor.createFromSystem (cursorType => GrafikEinstellungenSFML.FensterEinstellungen.MausZeiger);
      Sf.Graphics.RenderWindow.setMouseCursor (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               cursor       => GrafikEinstellungenSFML.MausAccess);
      
      MauszeigerPositionFestlegen (PositionExtern => (GrafikEinstellungenSFML.MausPosition));
      
   end MauszeigerFestlegen;
   
   
   
   procedure MauszeigerPositionFestlegen
     (PositionExtern : in Sf.System.Vector2.sfVector2i)
   is begin
      
      if
        PositionExtern.x <= 0
        or
          PositionExtern.y <= 0
          or
            Sf.sfUint32 (PositionExtern.x) > GrafikEinstellungenSFML.AktuelleFensterAuflösung.x
        or
          Sf.sfUint32 (PositionExtern.y) > GrafikEinstellungenSFML.AktuelleFensterAuflösung.y
      then
         Sf.Graphics.RenderWindow.Mouse.setPosition (position   => (1, 1),
                                                     relativeTo => GrafikEinstellungenSFML.FensterAccess);
         
      else
         Sf.Graphics.RenderWindow.Mouse.setPosition (position   => PositionExtern,
                                                     relativeTo => GrafikEinstellungenSFML.FensterAccess);
      end if;
      
   end MauszeigerPositionFestlegen;
   
   
   
   procedure SchriftartFestlegen
   is begin
      
      GrafikEinstellungenSFML.SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => "Sprachen/Schriftart/FreeSans.ttf");
      
   end SchriftartFestlegen;

end GrafikAllgemeinSFML;
