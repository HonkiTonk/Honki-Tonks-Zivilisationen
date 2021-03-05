pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleVariablen, GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with Wachstum, InDerStadtBauen, Karte, BefehleImSpiel, Optionen, Sichtbarkeit, EinheitenDatenbank, Verbesserungen, ForschungsDatenbank, KI, Ladezeiten, Speichern, Laden, KIZuruecksetzen, StadtProduktion;

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
                           when GlobaleKonstanten.StartNormalKonstante =>
                              null;

                           when GlobaleKonstanten.SpeichernKonstante => -- Speichern
                              GlobaleVariablen.RasseAmZugNachLaden := RasseIntern;
                              Speichern.SpeichernNeu (Autospeichern => False);
               
                           when GlobaleKonstanten.LadenKonstante => -- Laden
                              LadenErfolgreich := Laden.LadenNeu;
                              case LadenErfolgreich is
                                 when True =>
                                    exit RassenSchleife;

                                 when False =>
                                    null;
                              end case;
               
                           when GlobaleKonstanten.OptionenKonstante => -- Optionen
                              RückgabeOptionen := Optionen.Optionen;
                              case RückgabeOptionen is
                                 when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
                                    return RückgabeOptionen;
                                    
                                 when others =>
                                    null;
                              end case;
               
                           when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante => -- Spiel beenden oder Hauptmenü
                              return AktuellerBefehl;

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
               BerechnungenNachZugendeAllerSpieler;
               
            when others =>
               null;
         end case;
            
      end loop SpielSchleife;
            
   end ImSpiel;



   procedure BerechnungenNachZugendeAllerSpieler is
   begin
            
      Ladezeiten.BerechnungenNachZugendeAllerSpielerZeiten (1, 1) := Clock;
      EinheitenDatenbank.HeilungBewegungspunkteFürNeueRundeSetzen;
      Verbesserungen.VerbesserungFertiggestellt;
      Wachstum.Wachstum;
      InDerStadtBauen.BauzeitAlle;
      StadtProduktion.StadtProduktionPrüfen ((0, 0));
      ForschungsDatenbank.ForschungFortschritt;
      GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;

      case GlobaleVariablen.AnzahlAutosave is
         when 0 =>
            null;

         when others =>
            Speichern.AutoSpeichern;
      end case;
      
      KIZuruecksetzen.KIZurücksetzenAmRundenende;
      Ladezeiten.BerechnungenNachZugendeAllerSpielerZeiten (2, 1) := Clock;
      Ladezeiten.BerechnungenNachZugendeAllerSpieler (WelcheZeit => 1);
      
   end BerechnungenNachZugendeAllerSpieler;

end ImSpiel;
