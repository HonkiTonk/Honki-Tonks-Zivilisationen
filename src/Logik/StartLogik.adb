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
      
      NachGrafiktask.Spielstart.ErzeugeFenster := True;
      
      -- Solche Warteschleifen mal alle in einer Datei sammeln und entsprechend aufrufen? äöü
      -- Lohnt sich das? So oft verwende ich die ja nicht. äöü
      FensterVorhandenSchleife:
      while NachLogiktask.GrafikWarten loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop FensterVorhandenSchleife;
      
      EinlesenLogik.EinlesenMitAnzeige;
      NachGrafiktask.Texteinstellungen.SchriftgrößeSetzen := True;
      NachGrafiktask.Texteinstellungen.SchriftfarbeSetzen := True;
      NachGrafiktask.Texteinstellungen.SchriftstilSetzen := True;
      NachGrafiktask.Texteinstellungen.TextSetzen := True;
      
      NachGrafiktask.Grafik.AktuelleDarstellung := GrafikDatentypen.Intro_Enum;
      
      IntroSchleife:
      while NachLogiktask.IntroAbwarten loop
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Abwählen_Enum =>
               NachGrafiktask.Spielstart.IntroBeenden := True;
               
            when others =>
               null;
         end case;
         
      end loop IntroSchleife;
      
      HauptmenueLogik.Hauptmenü;
      
   end StartLogik;
   
end StartLogik;
