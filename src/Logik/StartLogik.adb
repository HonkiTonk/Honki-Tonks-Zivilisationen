with Ada.Real_Time; use Ada.Real_Time;

with GrafikDatentypen;
with ZeitKonstanten;
with TastenbelegungDatentypen;

with SchreibenVerzeichnisseLogik;
with EinlesenEinstellungenLogik;
with EinlesenLogik;
with HauptmenueLogik;
with NachGrafiktask;
with NachLogiktask;
with LogiktaskAnAlle;
with TasteneingabeLogik;

package body StartLogik is

   procedure StartLogik
   is begin
      
      SchreibenVerzeichnisseLogik.SchreibenVerzeichnisse;
      EinlesenEinstellungenLogik.EinlesenEinstellungen;
      
      EinlesenLogik.EinlesenOhneAnzeige;
      
      NachGrafiktask.ErzeugeFenster := True;
      
      FensterVorhandenSchleife:
      while NachLogiktask.Warten loop
         
         delay until Clock + ZeitKonstanten.WartezeitLogik;
         
      end loop FensterVorhandenSchleife;
      
      EinlesenLogik.EinlesenMitAnzeige;
      NachGrafiktask.AccesseSetzen := True;
      
      LogiktaskAnAlle.EinlesenAbgeschlossen := True;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Intro_Enum;
      
      IntroSchleife:
      while NachLogiktask.IntroAbwarten loop
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Abwählen_Enum =>
               NachGrafiktask.IntroAnzeigen := False;
               
            when others =>
               null;
         end case;
         
      end loop IntroSchleife;
      
      HauptmenueLogik.Hauptmenü;
      
   end StartLogik;
   
end StartLogik;
