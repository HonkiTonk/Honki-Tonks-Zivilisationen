pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;
with Sf.Window.VideoMode;

with SonstigesKonstanten;

with GrafikEinstellungenSFML;
with GrafikAllgemeinSFML;
with Fehler;
with TexteinstellungenSFML;

package body GrafikStartEndeSFML is

   procedure FensterErzeugen
   is begin
      
      FensterErzeugenErweitert;

      if
        GrafikEinstellungenSFML.FensterAccess = null
      then
         Fehler.GrafikFehler (FehlermeldungExtern => "GrafikStartEndeSFML.FensterErzeugen - FensterAccess = null.");

      else
         GrafikAllgemeinSFML.MauszeigerFestlegen;
         GrafikAllgemeinSFML.BildrateÄndern;
         TexteinstellungenSFML.SchriftartFestlegen;
         GrafikAllgemeinSFML.AktuelleAuflösungFestlegen;
      end if;
      
   end FensterErzeugen;
   
   
   
   procedure FensterErzeugenErweitert
   is begin
      
      case
        GrafikEinstellungenSFML.FensterEinstellungen.FensterVollbild
      is
         when 7 =>
            GrafikEinstellungenSFML.FensterAccess := Sf.Graphics.RenderWindow.createUnicode (mode  => (GrafikEinstellungenSFML.FensterEinstellungen.FensterBreite,
                                                                                                       GrafikEinstellungenSFML.FensterEinstellungen.FensterHöhe,
                                                                                                       GrafikEinstellungenSFML.FensterEinstellungen.Farbtiefe),
                                                                                             title => SonstigesKonstanten.Spielname,
                                                                                             style => GrafikEinstellungenSFML.FensterEinstellungen.FensterVollbild);
            
            -- Die Vollbildauflösung noch seperat speichern? äöü
         when 8 =>
            GrafikEinstellungenSFML.FensterAccess := Sf.Graphics.RenderWindow.createUnicode (mode  => (Sf.Window.VideoMode.getDesktopMode.width,
                                                                                                       Sf.Window.VideoMode.getDesktopMode.height,
                                                                                                       GrafikEinstellungenSFML.FensterEinstellungen.Farbtiefe),
                                                                                             title => SonstigesKonstanten.Spielname,
                                                                                             style => GrafikEinstellungenSFML.FensterEinstellungen.FensterVollbild);
            
         when others =>
            Fehler.GrafikFehler (FehlermeldungExtern => "GrafikStartEndeSFML.FensterErzeugenErweitert - Unbekannter Fenstermodus gewählt.");
      end case;
            
   end FensterErzeugenErweitert;
   
   
   
   procedure FensterEntfernen
   is begin
      
      Sf.Graphics.RenderWindow.destroy (renderWindow => GrafikEinstellungenSFML.FensterAccess);
      
   end FensterEntfernen;
   
   
   
   procedure FensterLeeren
   is begin
      
      Sf.Graphics.RenderWindow.clear (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                      color        => Sf.Graphics.Color.sfBlack);
      
   end FensterLeeren;
   
   
   
   procedure FensterAnzeigen
   is begin
      
      Sf.Graphics.RenderWindow.display (renderWindow => GrafikEinstellungenSFML.FensterAccess);
      
   end FensterAnzeigen;
  
end GrafikStartEndeSFML;
