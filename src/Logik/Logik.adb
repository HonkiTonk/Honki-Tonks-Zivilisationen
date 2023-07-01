with GrafikDatentypen;
with ZeitKonstanten;
with TastenbelegungDatentypen;

with LeseLogiktask;
with SchreibeGrafiktask;
with SchreibeGesamttask;

with SchreibenVerzeichnisseLogik;
with EinlesenEinstellungenLogik;
with EinlesenLogik;
with HauptmenueLogik;
with TasteneingabeLogik;

package body Logik is

   procedure Logik
   is begin
      
      SchreibenVerzeichnisseLogik.SchreibenVerzeichnisse;
      EinlesenEinstellungenLogik.EinlesenEinstellungen;
      
      EinlesenLogik.EinlesenOhneAnzeige;
      SchreibeGesamttask.EinstellungenEingelesen (JaNeinExtern => True);
      
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
      
      SchreibeGrafiktask.FensterErzeugen (JaNeinExtern => True);
      
      -- Solche Warteschleifen mal alle in einer Datei sammeln und entsprechend aufrufen? äöü
      -- Lohnt sich das? So oft verwende ich die ja nicht. äöü
      FensterVorhandenSchleife:
      while LeseLogiktask.WartenGrafik = True loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop FensterVorhandenSchleife;
      
      EinlesenLogik.EinlesenMitAnzeige;
      SchreibeGrafiktask.SchriftgrößeSetzen (JaNeinExtern => True);
      SchreibeGrafiktask.SchriftfarbeSetzen (JaNeinExtern => True);
      SchreibeGrafiktask.SchriftstilSetzen (JaNeinExtern => True);
      SchreibeGrafiktask.TextSetzen (JaNeinExtern => True);
            
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Intro_Enum);
      
      IntroSchleife:
      while LeseLogiktask.WartenIntro = True loop
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Abwählen_Enum =>
               SchreibeGrafiktask.IntroBeenden (JaNeinExtern => True);
               
            when others =>
               null;
         end case;
         
      end loop IntroSchleife;
      
      HauptmenueLogik.Hauptmenü;
      
   end Logik;
   
end Logik;
