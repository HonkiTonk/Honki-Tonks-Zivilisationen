pragma SPARK_Mode (On);

with Sf; use Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Font;
with Sf.Window.Cursor;

with StartEndeSFML;
with EinstellungenSFML;
with InteraktionGrafiktask;

package body AllgemeinSFML is
      
   procedure FensterAnpassen
   is begin
      
      case
        InteraktionGrafiktask.FensterVerändert
      is
         when InteraktionGrafiktask.Auflösung_Verändert | InteraktionGrafiktask.Modus_Verändert =>
            StartEndeSFML.FensterEntfernen;
            StartEndeSFML.FensterErzeugen;
            EinstellungenSFML.AktuelleFensterAuflösung.x := Sf.Graphics.RenderWindow.getSize (renderWindow => EinstellungenSFML.FensterAccess).x;
            EinstellungenSFML.AktuelleFensterAuflösung.y := Sf.Graphics.RenderWindow.getSize (renderWindow => EinstellungenSFML.FensterAccess).y;
            InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Keine_Änderung;
            
         when others =>
            EinstellungenSFML.AktuelleFensterAuflösung.x := Sf.Graphics.RenderWindow.getSize (renderWindow => EinstellungenSFML.FensterAccess).x;
            EinstellungenSFML.AktuelleFensterAuflösung.y := Sf.Graphics.RenderWindow.getSize (renderWindow => EinstellungenSFML.FensterAccess).y;
            
            Sf.Graphics.View.setSize (view => NeueAuflösungAccess,
                                      size => (Float (EinstellungenSFML.AktuelleFensterAuflösung.x), Float (EinstellungenSFML.AktuelleFensterAuflösung.y)));
            Sf.Graphics.View.setCenter (view   => NeueAuflösungAccess,
                                        center => (Float (EinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, Float (EinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00));
      
            Sf.Graphics.RenderWindow.setView (renderWindow => EinstellungenSFML.FensterAccess,
                                              view         => NeueAuflösungAccess);
      end case;
      
   end FensterAnpassen;
   
   
   
   procedure BildrateÄndern
   is begin
      
      Sf.Graphics.RenderWindow.setFramerateLimit (renderWindow => EinstellungenSFML.FensterAccess,
                                                  limit        => EinstellungenSFML.FensterEinstellungen.Bildrate);
      
   end BildrateÄndern;
   
   
   
   procedure MauszeigerFestlegen
   is begin
      
      EinstellungenSFML.MausAccess := Sf.Window.Cursor.createFromSystem (cursorType => EinstellungenSFML.FensterEinstellungen.MausZeiger);
      Sf.Graphics.RenderWindow.setMouseCursor (renderWindow => EinstellungenSFML.FensterAccess,
                                               cursor       => EinstellungenSFML.MausAccess);
      
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
      
      EinstellungenSFML.SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => "Sprachen/Schriftart/FreeSans.ttf");
      
   end SchriftartFestlegen;

end AllgemeinSFML;
