pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen; use GrafikDatentypen;
with ZeitKonstanten;

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
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop FensterVorhandenSchleife;
      
      Einlesen.EinlesenMitAnzeige;
      InteraktionGrafiktask.AccesseSetzen := True;
      
      InteraktionLogiktask.EinlesenAbgeschlossen := True;
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Intro_Enum);
      
      IntroSchleife:
      while InteraktionGrafiktask.AktuelleDarstellungAbrufen = GrafikDatentypen.Grafik_Intro_Enum loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop IntroSchleife;
      
      Hauptmenue.Hauptmenü;
      
   end StartLogik;
   
end StartLogik;
