pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Color;

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
            EinstellungenSFML.FensterAccess := Sf.Graphics.RenderWindow.createUnicode (mode  => (EinstellungenSFML.FensterEinstellungen.FensterBreite,
                                                                                                 EinstellungenSFML.FensterEinstellungen.FensterHöhe,
                                                                                                 EinstellungenSFML.FensterEinstellungen.Farbtiefe),
                                                                                       title => Name);
            EinstellungenSFML.AktuelleFensterAuflösung.x := EinstellungenSFML.FensterEinstellungen.FensterBreite;
            EinstellungenSFML.AktuelleFensterAuflösung.y := EinstellungenSFML.FensterEinstellungen.FensterHöhe;
      end case;

      if
        EinstellungenSFML.FensterAccess = null
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "GrafikStartEnde.FensterErzeugen - FensterAccess = null.");

      else
         AllgemeinSFML.MauszeigerFestlegen;
         AllgemeinSFML.BildrateÄndern (NeueBildrateExtern => EinstellungenSFML.FensterEinstellungen.Bildrate);
         AllgemeinSFML.SchriftartFestlegen;
      end if;
      
   end FensterErzeugen;
   
   
   
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
