pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;

with GlobaleVariablen;
with SystemDatentypen;

with GrafikEinstellungen;
with GrafikAllgemein;
with Fehler;

package body GrafikStartEnde is

   procedure FensterErzeugen
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            Fehler.GrafikStopp (FehlermeldungExtern => "GrafikStartEnde.FensterErzeugen - Es soll ein Konsolenfenster erzeugt werden.");
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            GrafikEinstellungen.Fenster := Sf.Graphics.RenderWindow.createUnicode (mode  => (GrafikEinstellungen.FensterEinstellungen.FensterBreite,
                                                                                             GrafikEinstellungen.FensterEinstellungen.FensterHöhe,
                                                                                             GrafikEinstellungen.FensterEinstellungen.Farbtiefe),
                                                                                   title => Name);
            GrafikEinstellungen.AktuelleFensterAuflösung.x := GrafikEinstellungen.FensterEinstellungen.FensterBreite;
            GrafikEinstellungen.AktuelleFensterAuflösung.y := GrafikEinstellungen.FensterEinstellungen.FensterHöhe;
      end case;

      if
        GrafikEinstellungen.Fenster = null
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "GrafikStartEnde.FensterErzeugen - Das Fenster ist null.");

      else
         GrafikAllgemein.MauszeigerFestlegen;
         GrafikAllgemein.BildrateÄndern (NeueBildrateExtern => GrafikEinstellungen.FensterEinstellungen.Bildrate);
         GrafikAllgemein.SchriftartFestlegen;
         GrafikAllgemein.TextAllgemeinFestlegen;
      end if;
      
   end FensterErzeugen;
   
   
   
   procedure FensterEntfernen
   is begin
      
      Sf.Graphics.RenderWindow.destroy (renderWindow => GrafikEinstellungen.Fenster);
      
   end FensterEntfernen;
   
   
   
   procedure FensterLeeren
   is begin
      
      Sf.Graphics.RenderWindow.clear (renderWindow => GrafikEinstellungen.Fenster,
                                      color        => Sf.Graphics.Color.sfBlack);
      
   end FensterLeeren;
   
   
   
   procedure FensterAnzeigen
   is begin
      
      Sf.Graphics.RenderWindow.display (renderWindow => GrafikEinstellungen.Fenster);
      
   end FensterAnzeigen;

end GrafikStartEnde;
