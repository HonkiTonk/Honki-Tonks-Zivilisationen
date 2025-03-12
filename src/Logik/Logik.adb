with MeldungsvariablenHTSEB;
with UmwandlungsvariablenHTSEB;
with DateisystemvariablenHTSEB;

with GrafikDatentypen;
with ZeitKonstanten;
with TastenbelegungDatentypen;
with Projekteinstellungen;
with TonDatentypen;
with SonstigesKonstanten;

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
      
      MeldungsvariablenHTSEB.FehlerMeldungWechseln (FehlerMeldungExtern => Projekteinstellungen.Einstellungen.FehlerWarnung);
      MeldungsvariablenHTSEB.VersionsnummerWechseln (VersionsnummerExtern => SonstigesKonstanten.Versionsnummer);
      UmwandlungsvariablenHTSEB.KodierungWechseln (KodierungExtern => Projekteinstellungen.Einstellungen.Stringkodierung);
      DateisystemvariablenHTSEB.DateiformWechseln (DateiformExtern => Projekteinstellungen.Einstellungen.Dateiform);
      DateisystemvariablenHTSEB.BetriebssystemWechseln (BetriebssystemExtern => Projekteinstellungen.Einstellungen.Betriebssystem);
      
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
            
      SchreibeMusiktask.NeueMusikart (MusikExtern => TonDatentypen.Musik_Intro_Enum);
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
      
      SchreibeMusiktask.NeueMusikart (MusikExtern => TonDatentypen.Musik_Spiel_Enum);
      
      HauptmenueLogik.Hauptmenü;
      
   end Logik;
   
end Logik;
