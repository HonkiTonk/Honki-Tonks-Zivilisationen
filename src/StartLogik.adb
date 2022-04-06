pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikTonDatentypen; use GrafikTonDatentypen;
with SystemKonstanten;

with SchreibenVerzeichnisse;
with EinlesenEinstellungen;
with Einlesen;
with InteraktionLogiktask;
with Hauptmenue;
with InteraktionGrafiktask;

package body StartLogik is

   procedure StartLogik
   is begin
      
      SchreibenVerzeichnisse.SchreibenVerzeichnisse;
      EinlesenEinstellungen.EinlesenEinstellungen;
      
      Einlesen.EinlesenOhneAnzeige;
      
      InteraktionGrafiktask.ErzeugeFensterÄndern;
      
      FensterVorhandenSchleife:
      while InteraktionLogiktask.FensterErzeugtAbrufen = False loop
         
         delay SystemKonstanten.WartezeitLogik;
         
      end loop FensterVorhandenSchleife;
      
      Einlesen.EinlesenMitAnzeige;
      
      InteraktionLogiktask.EinlesenAbgeschlossen := True;
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Intro_Enum);
      
      IntroSchleife:
      while InteraktionGrafiktask.AktuelleDarstellungAbrufen = GrafikTonDatentypen.Grafik_Intro_Enum loop
         
         delay SystemKonstanten.WartezeitLogik;
         
      end loop IntroSchleife;
      
      Hauptmenue.Hauptmenü;
      
   end StartLogik;
   
end StartLogik;
