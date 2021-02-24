pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

with InDerStadt, Wachstum, InDerStadtBauen, Karte, BefehleImSpiel, Optionen, Sichtbarkeit, EinheitenDatenbank, Verbesserungen, ForschungsDatenbank, KI, Ladezeiten, Speichern, Laden, KIZuruecksetzen;

package body ImSpiel is

   function ImSpiel return Integer is
   begin
      
      SpielSchleife:
      loop         
         RassenSchleife:
         for RasseIntern in GlobaleVariablen.RassenImSpiel'Range loop
            
            if GlobaleVariablen.RasseAmZugNachLaden = 0 or RasseIntern = GlobaleVariablen.RasseAmZugNachLaden then
               GlobaleVariablen.RasseAmZugNachLaden := 0;
               case GlobaleVariablen.RassenImSpiel (RasseIntern) is -- Einmal muss am Anfang die Sichtbarkeit geprüft werden, sonst crasht das Spiel
                  when 0 =>
                     null;
                  
                  when others =>
                     Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseIntern);
               end case;
            
               case GlobaleVariablen.RassenImSpiel (RasseIntern) is -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
                  when 0 =>
                     null;
                     
                  when 1 =>
                     SpielerSchleife:
                     loop
                     
                        Karte.AnzeigeKarte (RasseExtern => RasseIntern);
                        AktuellerBefehl := BefehleImSpiel.Befehle (RasseExtern => RasseIntern);
                        case AktuellerBefehl is
                           when 1 =>
                              null;

                           when 2 => -- Speichern
                              GlobaleVariablen.RasseAmZugNachLaden := RasseIntern;
                              Speichern.SpeichernNeu (AutoSpeichern => False);
               
                           when 3 => -- Laden
                              Laden.LadenNeu;
                              exit RassenSchleife;
               
                           when 4 =>
                              Optionen.Optionen;
               
                           when 0 => -- Hauptmenü
                              return 0;

                           when -1 => -- Spiel beenden
                              return -1;

                           when -1_000 => -- Runde beenden
                              exit SpielerSchleife;      
                  
                           when others =>
                              Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseIntern);
                        end case;
                     
                     end loop SpielerSchleife;
                  
                  when others =>
                     KI.KI (RasseExtern => RasseIntern);
               end case;

            else
               null;
            end if;
            
         end loop RassenSchleife;
                  
         case GlobaleVariablen.RasseAmZugNachLaden is
            when 0 =>
               Ladezeiten.BerechnungenNachZugendeAllerSpielerZeiten (1, 1) := Clock;
               EinheitenDatenbank.HeilungBewegungspunkteFürNeueRundeSetzen;
               Verbesserungen.VerbesserungFertiggestellt;
               Wachstum.Wachstum;
               InDerStadtBauen.BauzeitAlle;
               InDerStadt.StadtProduktionPrüfen ((0, 0));
               ForschungsDatenbank.ForschungFortschritt;
               GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;
               Speichern.AutoSpeichern;
               KIZuruecksetzen.KIZurücksetzenAmRundenende;
               Ladezeiten.BerechnungenNachZugendeAllerSpielerZeiten (2, 1) := Clock;
               Ladezeiten.BerechnungenNachZugendeAllerSpieler (WelcheZeit => 1);
               
            when others =>
               null;
         end case;
         
      end loop SpielSchleife;
            
   end ImSpiel;

end ImSpiel;
