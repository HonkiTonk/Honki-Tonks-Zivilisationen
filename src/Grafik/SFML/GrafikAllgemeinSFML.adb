pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Font;
with Sf.Window.Cursor;

with GrafikDatentypen;

with GrafikStartEndeSFML;
with GrafikEinstellungenSFML;
with NachGrafiktask;
with ViewsEinstellenSFML;

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
            ViewsEinstellenSFML.StandardviewGeändert;
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
        Sf.sfUint32 (PositionExtern.x) in 0 .. GrafikEinstellungenSFML.AktuelleFensterAuflösung.x
        and
          Sf.sfUint32 (PositionExtern.y) in 0 .. GrafikEinstellungenSFML.AktuelleFensterAuflösung.y
      then
         Sf.Graphics.RenderWindow.Mouse.setPosition (position   => PositionExtern,
                                                     relativeTo => GrafikEinstellungenSFML.FensterAccess);
         
      else
         Sf.Graphics.RenderWindow.Mouse.setPosition (position   => (1, 1),
                                                     relativeTo => GrafikEinstellungenSFML.FensterAccess);
      end if;
      
   end MauszeigerPositionFestlegen;
   
   
   
   procedure SchriftartFestlegen
   is begin
      
      GrafikEinstellungenSFML.SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => "Sprachen/Schriftart/FreeSans.ttf");
      
   end SchriftartFestlegen;

end GrafikAllgemeinSFML;
