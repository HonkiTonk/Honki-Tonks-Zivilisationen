pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf;
with Sf.Graphics.RenderWindow;
with Sf.Window.Cursor;
with Sf.Window.VideoMode;
with Sf.Graphics.Color;

with GrafikDatentypen;
with SonstigesKonstanten;

with EinstellungenGrafik;
with NachGrafiktask;
with Fehler;
with TexteinstellungenGrafik;

package body FensterGrafik is
   
   procedure FensterErzeugen
   is begin
      
      FensterErzeugenErweitert;

      if
        EinstellungenGrafik.FensterAccess = null
      then
         Fehler.GrafikFehler (FehlermeldungExtern => "FensterGrafik.FensterErzeugen: FensterAccess = null.");

      else
         MauszeigerFestlegen;
         BildrateÄndern;
         TexteinstellungenGrafik.SchriftartFestlegen;
         AktuelleAuflösungFestlegen;
      end if;
      
   end FensterErzeugen;
   
   
   
   procedure FensterErzeugenErweitert
   is begin
      
      case
        EinstellungenGrafik.FensterEinstellungen.FensterVollbild
      is
         when 7 =>
            EinstellungenGrafik.FensterAccess := Sf.Graphics.RenderWindow.createUnicode (mode  => (EinstellungenGrafik.FensterEinstellungen.FensterBreite,
                                                                                                   EinstellungenGrafik.FensterEinstellungen.FensterHöhe,
                                                                                                   EinstellungenGrafik.FensterEinstellungen.Farbtiefe),
                                                                                         title => SonstigesKonstanten.Spielname,
                                                                                         style => EinstellungenGrafik.FensterEinstellungen.FensterVollbild);
            
            -- Die Vollbildauflösung noch seperat speichern? äöü
         when 8 =>
            EinstellungenGrafik.FensterAccess := Sf.Graphics.RenderWindow.createUnicode (mode  => (Sf.Window.VideoMode.getDesktopMode.width,
                                                                                                   Sf.Window.VideoMode.getDesktopMode.height,
                                                                                                   EinstellungenGrafik.FensterEinstellungen.Farbtiefe),
                                                                                         title => SonstigesKonstanten.Spielname,
                                                                                         style => EinstellungenGrafik.FensterEinstellungen.FensterVollbild);
            
         when others =>
            Fehler.GrafikFehler (FehlermeldungExtern => "FensterGrafik.FensterErzeugenErweitert: Unbekannter Fenstermodus: " & EinstellungenGrafik.FensterEinstellungen.FensterVollbild'Wide_Wide_Image);
      end case;
            
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
      
      Sf.Graphics.RenderWindow.clear (renderWindow => EinstellungenGrafik.FensterAccess,
                                      color        => Sf.Graphics.Color.sfBlack);
      
   end FensterLeeren;
   
   
   
   procedure FensterAnzeigen
   is begin
      
      Sf.Graphics.RenderWindow.display (renderWindow => EinstellungenGrafik.FensterAccess);
      
   end FensterAnzeigen;
   
   
   
   procedure FensterEntfernen
   is begin
      
      Sf.Graphics.RenderWindow.destroy (renderWindow => EinstellungenGrafik.FensterAccess);
      
   end FensterEntfernen;
   
   
   
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

end FensterGrafik;
