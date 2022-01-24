pragma SPARK_Mode (On);

with Sf; use Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Font;
with Sf.Window.Cursor;

with EinstellungenSFML;

package body AllgemeinSFML is
      
   procedure FensterAnpassen
   is begin
            
      EinstellungenSFML.AktuelleFensterAuflösung.x := Sf.Graphics.RenderWindow.getSize (renderWindow => EinstellungenSFML.FensterAccess).x;
      EinstellungenSFML.AktuelleFensterAuflösung.y := Sf.Graphics.RenderWindow.getSize (renderWindow => EinstellungenSFML.FensterAccess).y;
      
      Sf.Graphics.View.setSize (view => NeueAuflösungAccess,
                                size => (Float (EinstellungenSFML.AktuelleFensterAuflösung.x), Float (EinstellungenSFML.AktuelleFensterAuflösung.y)));
      Sf.Graphics.View.setCenter (view   => NeueAuflösungAccess,
                                  center => (Float (EinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, Float (EinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00));
      
      Sf.Graphics.RenderWindow.setView (renderWindow => EinstellungenSFML.FensterAccess,
                                        view         => NeueAuflösungAccess);
      
   end FensterAnpassen;
   
   
   
   procedure BildrateÄndern
     (NeueBildrateExtern : in Sf.sfUint32)
   is begin
      
      Sf.Graphics.RenderWindow.setFramerateLimit (renderWindow => EinstellungenSFML.FensterAccess,
                                                  limit        => NeueBildrateExtern);
      
   end BildrateÄndern;
   
   
   
   procedure MauszeigerFestlegen
   is begin
      
      EinstellungenSFML.MausAccess := Sf.Window.Cursor.createFromSystem (cursorType => EinstellungenSFML.FensterEinstellungen.MausZeiger);
      Sf.Graphics.RenderWindow.setMouseCursor (renderWindow => EinstellungenSFML.FensterAccess,
                                               cursor       => EinstellungenSFML.MausAccess);
      
      EinstellungenSFML.MausPosition := (1, 1);
      MauszeigerPositionFestlegen (PositionExtern => (EinstellungenSFML.MausPosition));
      
   end MauszeigerFestlegen;
   
   
   
   procedure MauszeigerPositionFestlegen
     (PositionExtern : in Sf.System.Vector2.sfVector2i)
   is begin
      
      if
        PositionExtern.x <= 0
        or
          PositionExtern.y <= 0
          or
            Sf.sfUint32 (PositionExtern.x) > EinstellungenSFML.AktuelleFensterAuflösung.x
        or
          Sf.sfUint32 (PositionExtern.y) > EinstellungenSFML.AktuelleFensterAuflösung.y
      then
         Sf.Graphics.RenderWindow.Mouse.setPosition (position   => (1, 1),
                                                     relativeTo => EinstellungenSFML.FensterAccess);
         
      else
         Sf.Graphics.RenderWindow.Mouse.setPosition (position   => PositionExtern,
                                                     relativeTo => EinstellungenSFML.FensterAccess);
      end if;
      
   end MauszeigerPositionFestlegen;
   
   
   
   procedure SchriftartFestlegen
   is begin
      
      EinstellungenSFML.SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => "Sprachen/FreeSans.ttf");
      
   end SchriftartFestlegen;

end AllgemeinSFML;
