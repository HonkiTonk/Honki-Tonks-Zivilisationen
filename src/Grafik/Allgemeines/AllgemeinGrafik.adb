pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics.RenderWindow;
with Sf.Window.Cursor;

with GrafikDatentypen;

with StartEndeGrafik;
with EinstellungenGrafik;
with NachGrafiktask;

package body AllgemeinGrafik is
      
   procedure FensterAnpassen
   is begin
      
      case
        NachGrafiktask.FensterVerändert
      is
         when GrafikDatentypen.Auflösung_Verändert_Enum | GrafikDatentypen.Modus_Verändert_Enum =>
            StartEndeGrafik.FensterEntfernen;
            StartEndeGrafik.FensterErzeugen;
            
         when others =>
            null;
      end case;
      
      AktuelleAuflösungFestlegen;
      
   end FensterAnpassen;
   
   
   
   procedure AktuelleAuflösungFestlegen
   is begin
            
      EinstellungenGrafik.AktuelleFensterAuflösung.x := Float (Sf.Graphics.RenderWindow.getSize (renderWindow => EinstellungenGrafik.FensterAccess).x);
      EinstellungenGrafik.AktuelleFensterAuflösung.y := Float (Sf.Graphics.RenderWindow.getSize (renderWindow => EinstellungenGrafik.FensterAccess).y);
      
   end AktuelleAuflösungFestlegen;
   
   
   
   procedure BildrateÄndern
   is begin
      
      Sf.Graphics.RenderWindow.setFramerateLimit (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  limit        => EinstellungenGrafik.FensterEinstellungen.Bildrate);
      
   end BildrateÄndern;
   
   
   
   procedure MauszeigerFestlegen
   is begin
      
      EinstellungenGrafik.MausAccess := Sf.Window.Cursor.createFromSystem (cursorType => EinstellungenGrafik.FensterEinstellungen.MausZeiger);
      Sf.Graphics.RenderWindow.setMouseCursor (renderWindow => EinstellungenGrafik.FensterAccess,
                                               cursor       => EinstellungenGrafik.MausAccess);
      
   end MauszeigerFestlegen;

end AllgemeinGrafik;
