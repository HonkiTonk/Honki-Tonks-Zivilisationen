with GrafikDatentypen;
with ZeitKonstanten;
with TastenbelegungDatentypen;

with LeseLogiktask;

with SchreibenVerzeichnisseLogik;
with EinlesenEinstellungenLogik;
with EinlesenLogik;
with HauptmenueLogik;
with Grafiktask;
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
           LeseLogiktask.WartenSound
           or
             LeseLogiktask.WartenMusik
         then
            delay ZeitKonstanten.WartezeitLogik;
            
         else
            exit TonSchleife;
         end if;
         
      end loop TonSchleife;
      
      Grafiktask.Spielstart.ErzeugeFenster := True;
      
      -- Solche Warteschleifen mal alle in einer Datei sammeln und entsprechend aufrufen? äöü
      -- Lohnt sich das? So oft verwende ich die ja nicht. äöü
      FensterVorhandenSchleife:
      while LeseLogiktask.WartenGrafik = True loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop FensterVorhandenSchleife;
      
      EinlesenLogik.EinlesenMitAnzeige;
      Grafiktask.Texteinstellungen.SchriftgrößeSetzen := True;
      Grafiktask.Texteinstellungen.SchriftfarbeSetzen := True;
      Grafiktask.Texteinstellungen.SchriftstilSetzen := True;
      Grafiktask.Texteinstellungen.TextSetzen := True;
      
      Grafiktask.Grafik.AktuelleDarstellung := GrafikDatentypen.Intro_Enum;
      
      IntroSchleife:
      while LeseLogiktask.WartenIntro = True loop
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Abwählen_Enum =>
               Grafiktask.Spielstart.IntroBeenden := True;
               
            when others =>
               null;
         end case;
         
      end loop IntroSchleife;
      
      HauptmenueLogik.Hauptmenü;
      
   end StartLogik;
   
end StartLogik;
