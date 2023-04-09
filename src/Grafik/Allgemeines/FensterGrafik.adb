with Sf;
with Sf.Graphics.RenderWindow;
with Sf.Window.Cursor;
with Sf.Window.VideoMode;
with Sf.Graphics.Color;

with GrafikDatentypen;
with SonstigesKonstanten;

with LeseEinstellungenGrafik;

with NachGrafiktask;
with Fehlermeldungssystem;
with TexteinstellungenGrafik;

package body FensterGrafik is
   
   procedure FensterErzeugen
   is begin
      
      FensterErzeugenErweitert;

      if
        FensterAccess = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "FensterGrafik.FensterErzeugen: FensterAccess: null");
         raise FensterNichtErzeugbar;

      else
         MauszeigerFestlegen;
         BildrateÄndern;
         TexteinstellungenGrafik.SchriftartFestlegen;
         AktuelleAuflösungFestlegen;
      end if;
      
   end FensterErzeugen;
   
   
   
   procedure FensterErzeugenErweitert
   is begin
      
      -- FensterVollbild:
      -- No border / title bar = 0
      -- Title bar + fixed border = 1
      -- Titlebar + resizable border + maximize button = 2
      -- Titlebar + close button = 4
      -- Fullscreen mode = 8
      -- Default window style = 7
      Fenstermodus := LeseEinstellungenGrafik.Fenstermodus;
      
      case
        Fenstermodus
      is
         when 0 | 1 | 2 | 4 | 7 =>
            Startauflösung := LeseEinstellungenGrafik.Auflösung;
            
            -- Die Vollbildauflösung noch seperat speichern? äöü
         when 8 =>
            Startauflösung := (Sf.Window.VideoMode.getDesktopMode.width, Sf.Window.VideoMode.getDesktopMode.height);
            
         when others =>
            Fehlermeldungssystem.Grafik (FehlermeldungExtern => "FensterGrafik.FensterErzeugenErweitert: Unbekannter Fenstermodus: " & Fenstermodus'Wide_Wide_Image);
            Fenstermodus := 2;
            Startauflösung := (640, 480);
      end case;
            
      FensterAccess := Sf.Graphics.RenderWindow.createUnicode (mode  => (Startauflösung.x,
                                                                         Startauflösung.y,
                                                                         LeseEinstellungenGrafik.Farbtiefe),
                                                               title => SonstigesKonstanten.Spielname,
                                                               style => Fenstermodus);
            
   end FensterErzeugenErweitert;
   
   

   procedure FensterAnpassen
   is begin
      
      case
        NachGrafiktask.FensterVerändert
      is
         when GrafikDatentypen.Auflösung_Verändert_Enum | GrafikDatentypen.Modus_Verändert_Enum =>
            FensterEntfernen;
            FensterErzeugen;
            
         when others =>
            null;
      end case;
      
      AktuelleAuflösungFestlegen;
      
   end FensterAnpassen;
   
   
   
   procedure FensterLeeren
   is begin
      
      Sf.Graphics.RenderWindow.clear (renderWindow => FensterAccess,
                                      color        => Sf.Graphics.Color.sfBlack);
      
   end FensterLeeren;
   
   
   
   procedure FensterAnzeigen
   is begin
      
      Sf.Graphics.RenderWindow.display (renderWindow => FensterAccess);
      
   end FensterAnzeigen;
   
   
   
   procedure FensterEntfernen
   is begin
      
      Sf.Graphics.RenderWindow.destroy (renderWindow => FensterAccess);
      
   end FensterEntfernen;
   
   
   
   procedure AktuelleAuflösungFestlegen
   is begin
      
      Auflösung := Sf.Graphics.RenderWindow.getSize (renderWindow => FensterAccess);
            
      AktuelleFensterAuflösung := (Float (Auflösung.x), Float (Auflösung.y));
      
   end AktuelleAuflösungFestlegen;
   
   
   
   procedure BildrateÄndern
   is begin
      
      Sf.Graphics.RenderWindow.setFramerateLimit (renderWindow => FensterAccess,
                                                  limit        => LeseEinstellungenGrafik.Bildrate);
      
   end BildrateÄndern;
   
   
   
   procedure MauszeigerFestlegen
   is begin
      
      MausAccess := Sf.Window.Cursor.createFromSystem (cursorType => Sf.Window.Cursor.sfCursorCross);
      Sf.Graphics.RenderWindow.setMouseCursor (renderWindow => FensterAccess,
                                               cursor       => MausAccess);
      
   end MauszeigerFestlegen;
   
   
   
   function FensterLesen
     return Sf.Graphics.sfRenderWindow_Ptr
   is begin
      
      return FensterAccess;
      
   end FensterLesen;
   
   
   
   function AktuelleAuflösung
     return Sf.System.Vector2.sfVector2f
   is begin
      
      return AktuelleFensterAuflösung;
      
   end AktuelleAuflösung;

end FensterGrafik;
