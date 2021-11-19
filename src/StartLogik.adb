pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;

with SchreibenVerzeichnisse;
with EinlesenEinstellungen;
with Einlesen;
with SFMLDarstellungEinstellungen;
with Hauptmenue;

package body StartLogik is

   procedure StartLogik
   is begin
      
      SchreibenVerzeichnisse.SchreibenVerzeichnisse;
      EinlesenEinstellungen.EinlesenEinstellungen;
      
      Einlesen.EinlesenOhneAnzeige;
      
      SFMLDarstellungEinstellungen.ErzeugeFenster := True;
      
      FensterVorhandenSchleife:
      while SFMLDarstellungEinstellungen.FensterErzeugt = False loop
         
         delay SFMLDarstellungEinstellungen.Wartezeit;
         
      end loop FensterVorhandenSchleife;
      
      Einlesen.EinlesenMitAnzeige;
      
      SFMLDarstellungEinstellungen.AktuelleDarstellung := SystemDatentypen.SFML_Intro;
      
      IntroSchleife:
      while SFMLDarstellungEinstellungen.AktuelleDarstellung = SystemDatentypen.SFML_Intro loop
         
         delay SFMLDarstellungEinstellungen.Wartezeit;
         
      end loop IntroSchleife;
      
      Hauptmenue.Hauptmenü;
      
   end StartLogik;

end StartLogik;
