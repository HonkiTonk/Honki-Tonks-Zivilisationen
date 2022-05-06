pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;
with Sf.Window.VideoMode;

with GrafikDatentypen;
with SonstigesKonstanten;
with OptionenVariablen;

with GrafikEinstellungenSFML;
with GrafikAllgemeinSFML;
with Fehler;

package body GrafikStartEndeSFML is

   procedure FensterErzeugen
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "GrafikStartEndeSFML.FensterErzeugen - Es soll ein Konsolenfenster erzeugt werden.");
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            FensterErzeugenErweitert;
      end case;

      if
        GrafikEinstellungenSFML.FensterAccess = null
      then
         Fehler.GrafikFehler (FehlermeldungExtern => "GrafikStartEndeSFML.FensterErzeugen - FensterAccess = null.");

      else
         GrafikAllgemeinSFML.MauszeigerFestlegen;
         GrafikAllgemeinSFML.BildrateÄndern;
         GrafikAllgemeinSFML.SchriftartFestlegen;
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
                                                                                             title => SonstigesKonstanten.Spielename,
                                                                                             style => GrafikEinstellungenSFML.FensterEinstellungen.FensterVollbild);
      
            GrafikEinstellungenSFML.AktuelleFensterAuflösung.x := GrafikEinstellungenSFML.FensterEinstellungen.FensterBreite;
            GrafikEinstellungenSFML.AktuelleFensterAuflösung.y := GrafikEinstellungenSFML.FensterEinstellungen.FensterHöhe;
            
         when 8 =>
            GrafikEinstellungenSFML.AktuelleFensterAuflösung.x := Sf.Window.VideoMode.getDesktopMode.width;
            GrafikEinstellungenSFML.AktuelleFensterAuflösung.y := Sf.Window.VideoMode.getDesktopMode.height;
            GrafikEinstellungenSFML.FensterAccess := Sf.Graphics.RenderWindow.createUnicode (mode  => (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x,
                                                                                                       GrafikEinstellungenSFML.AktuelleFensterAuflösung.y,
                                                                                                       GrafikEinstellungenSFML.FensterEinstellungen.Farbtiefe),
                                                                                             title => SonstigesKonstanten.Spielename,
                                                                                             style => GrafikEinstellungenSFML.FensterEinstellungen.FensterVollbild);
            
         when others =>
            Fehler.GrafikFehler (FehlermeldungExtern => "GrafikStartEndeSFML.FensterErzeugenErweitert - Unbekannter Fenstermodus ausgewählt.");
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
