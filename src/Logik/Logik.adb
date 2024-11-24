with MeldungsvariablenHTB1;
-- with UmwandlungsvariablenHTB3;
with DateizugriffsvariablenHTB5;

with GrafikDatentypen;
with ZeitKonstanten;
with TastenbelegungDatentypen;
with Projekteinstellungen;
with TonDatentypen;

with LeseLogiktask;
with SchreibeGrafiktask;
with SchreibeGesamttask;
with SchreibeMusiktask;

with SchreibenVerzeichnisseLogik;
with EinlesenEinstellungenLogik;
with EinlesenLogik;
with HauptmenueLogik;
with TasteneingabeLogik;

package body Logik is

   procedure Logik
   is begin
      
      MeldungsvariablenHTB1.FehlerMeldungWechseln (FehlerMeldungExtern => Projekteinstellungen.Einstellungen.FehlerWarnung);
      -- UmwandlungsvariablenHTB3.KodierungWechseln (KodierungExtern => Projekteinstellungen.Einstellungen.Stringkodierung);
      DateizugriffsvariablenHTB5.DateiformWechseln (DateiformExtern => Projekteinstellungen.Einstellungen.Dateiform);
      
      SchreibenVerzeichnisseLogik.Verzeichnisse;
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
      SchreibeGrafiktask.SchriftrahmenSetzen (JaNeinExtern => True);
      SchreibeGrafiktask.TextSetzen (JaNeinExtern => True);
            
      SchreibeMusiktask.AktuelleMusik (MusikExtern => TonDatentypen.Musik_Intro_Enum);
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
