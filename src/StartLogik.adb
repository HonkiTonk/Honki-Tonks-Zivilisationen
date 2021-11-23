pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;

with SchreibenVerzeichnisse;
with EinlesenEinstellungen;
with Einlesen;
with GrafikWichtigeEinstellungen;
with Hauptmenue;

package body StartLogik is

   procedure StartLogik
   is begin
      
      SchreibenVerzeichnisse.SchreibenVerzeichnisse;
      EinlesenEinstellungen.EinlesenEinstellungen;
      
      Einlesen.EinlesenOhneAnzeige;
      
      GrafikWichtigeEinstellungen.ErzeugeFenster := True;
      
      FensterVorhandenSchleife:
      while GrafikWichtigeEinstellungen.FensterErzeugt = False loop
         
         delay GrafikWichtigeEinstellungen.Wartezeit;
         
      end loop FensterVorhandenSchleife;
      
      Einlesen.EinlesenMitAnzeige;
      
      GrafikWichtigeEinstellungen.AktuelleDarstellung := SystemDatentypen.Grafik_Intro;
      
      IntroSchleife:
      while GrafikWichtigeEinstellungen.AktuelleDarstellung = SystemDatentypen.Grafik_Intro loop
         
         delay GrafikWichtigeEinstellungen.Wartezeit;
         
      end loop IntroSchleife;
      
      Hauptmenue.Hauptmenü;
      
   end StartLogik;

end StartLogik;
