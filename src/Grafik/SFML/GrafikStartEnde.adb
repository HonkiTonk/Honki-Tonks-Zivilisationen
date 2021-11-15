pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with GlobaleVariablen;
with SystemDatentypen;

with GrafikEinstellungen;
with GrafikAllgemein;

package body GrafikStartEnde is

   procedure FensterErzeugen
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return;
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            GrafikEinstellungen.Fenster := Sf.Graphics.RenderWindow.createUnicode (mode  => (GrafikEinstellungen.FensterEinstellungen.FensterBreite,
                                                                                             GrafikEinstellungen.FensterEinstellungen.FensterHöhe,
                                                                                             GrafikEinstellungen.FensterEinstellungen.Farbtiefe),
                                                                                   title => Name);
      end case;

      if
        GrafikEinstellungen.Fenster = null
      then
         raise Program_Error;

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

end GrafikStartEnde;
