with Sf;
with Sf.Graphics.RenderWindow;
with Sf.Window.Cursor;
with Sf.Window.VideoMode;
with Sf.Graphics.Color;

with SonstigesKonstanten;
with GrafikKonstanten;

with LeseEinstellungenGrafik;
with SchreibeGrafiktask;

with MeldungssystemHTSEB;

package body FensterGrafik is
   
   procedure FensterErzeugen
   is begin
      
      FensterAccess := FensterErzeugenErweitert;

      if
        FensterAccess = null
      then
         MeldungssystemHTSEB.Grafik (MeldungExtern => "FensterGrafik.FensterErzeugen: FensterAccess: null");
         raise FensterNichtErzeugbar;

      else
         MauszeigerFestlegen;
         BildrateÄndern;
         AktuelleAuflösungFestlegen;
         SchreibeGrafiktask.SchriftartSetzen (JaNeinExtern => True);
      end if;
      
   end FensterErzeugen;
   
   
   
   function FensterErzeugenErweitert
     return Sf.Graphics.sfRenderWindow_Ptr
   is begin
      
      Fenstermodus := LeseEinstellungenGrafik.Fenstermodus;
      
      case
        Fenstermodus
      is
         when GrafikKonstanten.RahmenlosesFenster | GrafikKonstanten.TitelleisteFesteGrenzenFenster | GrafikKonstanten.TitelleisteGrößenänderungMaximierenFenster | GrafikKonstanten.TitelleisteSchließenFenster
            | GrafikKonstanten.StandardFenster =>
            Startauflösung := LeseEinstellungenGrafik.Auflösung;
            
            -- Die Vollbildauflösung noch seperat speichern? äöü
            -- Hier muss dann später noch eine Prüfung rein ob die gespeicherte Auflösung möglich ist. äöü
         when GrafikKonstanten.Vollbild =>
            Startauflösung := (Sf.Window.VideoMode.getDesktopMode.width, Sf.Window.VideoMode.getDesktopMode.height);
            
         when others =>
            MeldungssystemHTSEB.Grafik (MeldungExtern => "FensterGrafik.FensterErzeugenErweitert: Unbekannter Fenstermodus: " & Fenstermodus'Wide_Wide_Image);
            Fenstermodus := GrafikKonstanten.StandardFenster;
            Startauflösung := (GrafikKonstanten.MinimaleAuflösungsbreite, GrafikKonstanten.MinimaleAuflösunghöhe);
      end case;
      
      return Sf.Graphics.RenderWindow.createUnicode (mode  => (
                                                               width        => Startauflösung.x,
                                                               height       => Startauflösung.y,
                                                               bitsPerPixel => LeseEinstellungenGrafik.Farbtiefe
                                                              ),
                                                     title => SonstigesKonstanten.Spielname & " - " & SonstigesKonstanten.Versionsnummer,
                                                     style => Fenstermodus);
      
   end FensterErzeugenErweitert;
   
   

   procedure FensterAnpassen
     (FensterVerändertExtern : in GrafikDatentypen.Fenster_Anpassen_Enum)
   is begin
      
      case
        FensterVerändertExtern
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
      
      case
        LeseEinstellungenGrafik.VSync
      is
         when Sf.sfFalse =>
            Sf.Graphics.RenderWindow.setVerticalSyncEnabled (renderWindow => FensterAccess,
                                                             enabled      => Sf.sfFalse);
      
            Sf.Graphics.RenderWindow.setFramerateLimit (renderWindow => FensterAccess,
                                                        limit        => LeseEinstellungenGrafik.Bildrate);
            
         when Sf.sfTrue =>
            Sf.Graphics.RenderWindow.setFramerateLimit (renderWindow => FensterAccess,
                                                        limit        => 0);
      
            Sf.Graphics.RenderWindow.setVerticalSyncEnabled (renderWindow => FensterAccess,
                                                             enabled      => Sf.sfTrue);
      end case;
      
   end BildrateÄndern;
   
   
   
   procedure MauszeigerFestlegen
   is begin
      
      Sf.Graphics.RenderWindow.setMouseCursor (renderWindow => FensterAccess,
                                               cursor       => Sf.Window.Cursor.createFromSystem (cursorType => Sf.Window.Cursor.sfCursorCross));
      
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
