pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen; use GrafikDatentypen;
with ZeitKonstanten;

with SchreibenVerzeichnisse;
with EinlesenEinstellungen;
with Einlesen;
with Hauptmenue;
with InteraktionGrafiktask;
with InteraktionStart;
with InteraktionTextanzeige;

package body StartLogik is

   procedure StartLogik
   is begin
      
      SchreibenVerzeichnisse.SchreibenVerzeichnisse;
      EinlesenEinstellungen.EinlesenEinstellungen;
      
      Einlesen.EinlesenOhneAnzeige;
      
      InteraktionStart.ErzeugeFenster := True;
      
      FensterVorhandenSchleife:
      while InteraktionStart.FensterErzeugt = False loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop FensterVorhandenSchleife;
      
      Einlesen.EinlesenMitAnzeige;
      InteraktionTextanzeige.AccesseSetzen := True;
      
      InteraktionStart.EinlesenAbgeschlossen := True;
      InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Intro_Enum;
      
      IntroSchleife:
      while InteraktionGrafiktask.AktuelleDarstellung = GrafikDatentypen.Grafik_Intro_Enum loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop IntroSchleife;
      
      Hauptmenue.Hauptmenü;
      
   end StartLogik;
   
end StartLogik;
