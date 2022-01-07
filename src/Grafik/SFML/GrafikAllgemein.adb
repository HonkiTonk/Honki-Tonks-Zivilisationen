pragma SPARK_Mode (On);

-- with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf; use Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Font;
with Sf.Window.Cursor;

with GrafikEinstellungen;

package body GrafikAllgemein is
      
   procedure FensterAnpassen
   is begin
            
      GrafikEinstellungen.AktuelleFensterAuflösung.x := Sf.Graphics.RenderWindow.getSize (renderWindow => GrafikEinstellungen.FensterAccess).x;
      GrafikEinstellungen.AktuelleFensterAuflösung.y := Sf.Graphics.RenderWindow.getSize (renderWindow => GrafikEinstellungen.FensterAccess).y;
      
      Sf.Graphics.View.setSize (view => NeueAuflösungAccess,
                                size => (Float (GrafikEinstellungen.AktuelleFensterAuflösung.x), Float (GrafikEinstellungen.AktuelleFensterAuflösung.y)));
      Sf.Graphics.View.setCenter (view   => NeueAuflösungAccess,
                                  center => (Float (GrafikEinstellungen.AktuelleFensterAuflösung.x) / 2.00, Float (GrafikEinstellungen.AktuelleFensterAuflösung.y) / 2.00));
      
      Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungen.FensterAccess,
                                        view         => NeueAuflösungAccess);
      
   end FensterAnpassen;
   
   
   
   procedure BildrateÄndern
     (NeueBildrateExtern : in Sf.sfUint32)
   is begin
      
      Sf.Graphics.RenderWindow.setFramerateLimit (renderWindow => GrafikEinstellungen.FensterAccess,
                                                  limit        => NeueBildrateExtern);
      
   end BildrateÄndern;
   
   
   
   procedure MauszeigerFestlegen
   is begin
      
      GrafikEinstellungen.MausAccess := Sf.Window.Cursor.createFromSystem (cursorType => GrafikEinstellungen.FensterEinstellungen.MausZeiger);
      Sf.Graphics.RenderWindow.setMouseCursor (renderWindow => GrafikEinstellungen.FensterAccess,
                                               cursor       => GrafikEinstellungen.MausAccess);
      
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
          or
            Sf.sfUint32 (PositionExtern.x) > GrafikEinstellungen.AktuelleFensterAuflösung.x
        or
          Sf.sfUint32 (PositionExtern.y) > GrafikEinstellungen.AktuelleFensterAuflösung.y
      then
         Sf.Graphics.RenderWindow.Mouse.setPosition (position   => (1, 1),
                                                     relativeTo => GrafikEinstellungen.FensterAccess);
         
      else
         Sf.Graphics.RenderWindow.Mouse.setPosition (position   => PositionExtern,
                                                     relativeTo => GrafikEinstellungen.FensterAccess);
      end if;
      
   end MauszeigerPositionFestlegen;
   
   
   
   procedure SchriftartFestlegen
   is begin
      
      GrafikEinstellungen.SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => "Sprachen/FreeSans.ttf");
      
   end SchriftartFestlegen;

end GrafikAllgemein;
