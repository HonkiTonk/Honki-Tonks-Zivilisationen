pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;

with SchreibenVerzeichnisse;
with EinlesenEinstellungen;
with Einlesen;
with InteraktionTasks;
with Hauptmenue;

package body StartLogik is

   procedure StartLogik
   is begin
      
      SchreibenVerzeichnisse.SchreibenVerzeichnisse;
      EinlesenEinstellungen.EinlesenEinstellungen;
      
      Einlesen.EinlesenOhneAnzeige;
      
      InteraktionTasks.ErzeugeFensterÄndern;
      
      FensterVorhandenSchleife:
      while InteraktionTasks.FensterErzeugtAbrufen = False loop
         
         delay InteraktionTasks.WartezeitLogik;
         
      end loop FensterVorhandenSchleife;
      
      Einlesen.EinlesenMitAnzeige;
      
      InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Intro);
      
      IntroSchleife:
      while InteraktionTasks.AktuelleDarstellungAbrufen = SystemDatentypen.Grafik_Intro loop
         
         delay InteraktionTasks.WartezeitLogik;
         
      end loop IntroSchleife;
      
      Hauptmenue.Hauptmenü;
      
   end StartLogik;

end StartLogik;
