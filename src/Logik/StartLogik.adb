pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen; use GrafikDatentypen;
with ZeitKonstanten;

with SchreibenVerzeichnisse;
with EinlesenEinstellungen;
with Einlesen;
with Hauptmenue;
with NachGrafiktask;
with NachLogiktask;
with LogiktaskAnAlle;

package body StartLogik is

   procedure StartLogik
   is begin
      
      SchreibenVerzeichnisse.SchreibenVerzeichnisse;
      EinlesenEinstellungen.EinlesenEinstellungen;
      
      Einlesen.EinlesenOhneAnzeige;
      
      NachGrafiktask.ErzeugeFenster := True;
      
      FensterVorhandenSchleife:
      while NachLogiktask.Warten loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop FensterVorhandenSchleife;
      
      NachLogiktask.Warten := True;
      Einlesen.EinlesenMitAnzeige;
      NachGrafiktask.AccesseSetzen := True;
      
      LogiktaskAnAlle.EinlesenAbgeschlossen := True;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Intro_Enum;
      
      IntroSchleife:
      while NachLogiktask.Warten loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop IntroSchleife;
      
      Hauptmenue.Hauptmenü;
      
   end StartLogik;
   
end StartLogik;
