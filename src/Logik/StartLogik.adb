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
      LogiktaskAnAlle.EinlesenAbgeschlossen := True;
      
      TonSchleife:
      loop
         
         if
           NachLogiktask.SoundWarten
           or
             NachLogiktask.MusikWarten
         then
            delay ZeitKonstanten.WartezeitLogik;
            
         else
            exit TonSchleife;
         end if;
         
      end loop TonSchleife;
      
      NachGrafiktask.ErzeugeFenster := True;
      
      -- Solche Warteschleifen mal alle in einer Datei sammeln und entsprechend aufrufen? äöü
      FensterVorhandenSchleife:
      while NachLogiktask.GrafikWarten loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop FensterVorhandenSchleife;
      
      EinlesenLogik.EinlesenMitAnzeige;
      NachGrafiktask.AccesseSetzen := True;
      
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
