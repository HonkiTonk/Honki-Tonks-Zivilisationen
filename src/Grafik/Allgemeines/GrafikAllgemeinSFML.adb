pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics.RenderWindow;
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
            
         when others =>
            null;
      end case;
      
      AktuelleAuflösungFestlegen;
      
   end FensterAnpassen;
   
   
   
   procedure AktuelleAuflösungFestlegen
   is begin
            
      GrafikEinstellungenSFML.AktuelleFensterAuflösung.x := Float (Sf.Graphics.RenderWindow.getSize (renderWindow => GrafikEinstellungenSFML.FensterAccess).x);
      GrafikEinstellungenSFML.AktuelleFensterAuflösung.y := Float (Sf.Graphics.RenderWindow.getSize (renderWindow => GrafikEinstellungenSFML.FensterAccess).y);
      
   end AktuelleAuflösungFestlegen;
   
   
   
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
      
   end MauszeigerFestlegen;

end GrafikAllgemeinSFML;