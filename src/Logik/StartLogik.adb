pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen; use GrafikDatentypen;
with ZeitKonstanten;
with TastenbelegungDatentypen;

with SchreibenVerzeichnisse;
with EinlesenEinstellungen;
with Einlesen;
with HauptmenueLogik;
with NachGrafiktask;
with NachLogiktask;
with LogiktaskAnAlle;
with TasteneingabeLogik;

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
      
      Einlesen.EinlesenMitAnzeige;
      NachGrafiktask.AccesseSetzen := True;
      
      LogiktaskAnAlle.EinlesenAbgeschlossen := True;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Intro_Enum;
      
      IntroSchleife:
      while NachLogiktask.IntroAbwarten loop
         
         case
           TasteneingabeLogik.Tastenwert
         is
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               NachGrafiktask.IntroAnzeigen := False;
               
            when others =>
               null;
         end case;
         
      end loop IntroSchleife;
      
      HauptmenueLogik.Hauptmenü;
      
   end StartLogik;
   
end StartLogik;
