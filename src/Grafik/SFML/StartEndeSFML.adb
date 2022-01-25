pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;
with Sf.Window.VideoMode;

with GlobaleVariablen;
with SystemDatentypen;

with EinstellungenSFML;
with AllgemeinSFML;
with Fehler;

package body StartEndeSFML is

   procedure FensterErzeugen
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            Fehler.GrafikStopp (FehlermeldungExtern => "GrafikStartEnde.FensterErzeugen - Es soll ein Konsolenfenster erzeugt werden.");
            
         when SystemDatentypen.Grafik_SFML =>
            FensterErzeugenErweitert;
            
      end case;

      if
        EinstellungenSFML.FensterAccess = null
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "GrafikStartEnde.FensterErzeugen - FensterAccess = null.");

      else
         AllgemeinSFML.MauszeigerFestlegen;
         AllgemeinSFML.BildrateÄndern;
         AllgemeinSFML.SchriftartFestlegen;
      end if;
      
   end FensterErzeugen;
   
   
   
   procedure FensterErzeugenErweitert
   is begin
      
      case
        EinstellungenSFML.FensterEinstellungen.FensterVollbild
      is
         when 7 =>
            EinstellungenSFML.FensterAccess := Sf.Graphics.RenderWindow.createUnicode (mode  => (EinstellungenSFML.FensterEinstellungen.FensterBreite,
                                                                                                 EinstellungenSFML.FensterEinstellungen.FensterHöhe,
                                                                                                 EinstellungenSFML.FensterEinstellungen.Farbtiefe),
                                                                                       title => Name,
                                                                                       style => EinstellungenSFML.FensterEinstellungen.FensterVollbild);
      
            EinstellungenSFML.AktuelleFensterAuflösung.x := EinstellungenSFML.FensterEinstellungen.FensterBreite;
            EinstellungenSFML.AktuelleFensterAuflösung.y := EinstellungenSFML.FensterEinstellungen.FensterHöhe;
            
         when 8 =>
            EinstellungenSFML.AktuelleFensterAuflösung.x := Sf.Window.VideoMode.getDesktopMode.width;
            EinstellungenSFML.AktuelleFensterAuflösung.y := Sf.Window.VideoMode.getDesktopMode.height;
            EinstellungenSFML.FensterAccess := Sf.Graphics.RenderWindow.createUnicode (mode  => (EinstellungenSFML.AktuelleFensterAuflösung.x,
                                                                                                 EinstellungenSFML.AktuelleFensterAuflösung.y,
                                                                                                 EinstellungenSFML.FensterEinstellungen.Farbtiefe),
                                                                                       title => Name,
                                                                                       style => EinstellungenSFML.FensterEinstellungen.FensterVollbild);
            
         when others =>
            Fehler.GrafikStopp (FehlermeldungExtern => "StartEndeSFML.FensterErzeugenErweitert - Unbekannter Fenstermodus ausgewählt.");
      end case;
            
   end FensterErzeugenErweitert;
   
   
   
   procedure FensterEntfernen
   is begin
      
      Sf.Graphics.RenderWindow.destroy (renderWindow => EinstellungenSFML.FensterAccess);
      
   end FensterEntfernen;
   
   
   
   procedure FensterLeeren
   is begin
      
      Sf.Graphics.RenderWindow.clear (renderWindow => EinstellungenSFML.FensterAccess,
                                      color        => Sf.Graphics.Color.sfBlack);
      
   end FensterLeeren;
   
   
   
   procedure FensterAnzeigen
   is begin
      
      Sf.Graphics.RenderWindow.display (renderWindow => EinstellungenSFML.FensterAccess);
      
   end FensterAnzeigen;

end StartEndeSFML;
