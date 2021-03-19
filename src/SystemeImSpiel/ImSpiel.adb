pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleVariablen, GlobaleKonstanten;

with Wachstum, InDerStadtBauen, Karte, BefehleImSpiel, Optionen, Sichtbarkeit, EinheitenDatenbank, Verbesserungen, ForschungsDatenbank, KI, Ladezeiten, Speichern, Laden, KIZuruecksetzen, StadtProduktion;

package body ImSpiel is

   function ImSpiel return Integer is
   begin
      
      SpielSchleife:
      loop         
         RassenSchleife:
         for RasseSchleifenwert in GlobaleDatentypen.Rassen'Range loop
            
            if GlobaleVariablen.RasseAmZugNachLaden = 0 or RasseSchleifenwert = GlobaleVariablen.RasseAmZugNachLaden then
               GlobaleVariablen.RasseAmZugNachLaden := 0;
               case GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) is -- Einmal muss am Anfang die Sichtbarkeit geprüft werden, sonst crasht das Spiel
                  when 0 =>
                     null;
                  
                  when others =>
                     Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseSchleifenwert);
               end case;
            
               case GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) is -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
                  when 0 =>
                     null;
                     
                  when 1 =>
                     RückgabeWert := MenschlicherSpieler (RasseExtern => RasseSchleifenwert);
                     case RückgabeWert is
                        when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
                           return RückgabeOptionen;

                        when -300 =>
                           exit RassenSchleife;
                        
                        when others =>
                           null;
                     end case;
                  
                  when others =>
                     KI.KI (RasseExtern => RasseSchleifenwert);
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



   function MenschlicherSpieler (RasseExtern : in GlobaleDatentypen.Rassen) return Integer is
   begin
      
      SpielerSchleife:
      loop
                     
         Karte.AnzeigeKarte (RasseExtern => RasseExtern);
         AktuellerBefehlSpieler := BefehleImSpiel.Befehle (RasseExtern => RasseExtern);
         case AktuellerBefehlSpieler is
            when GlobaleKonstanten.StartNormalKonstante =>
               null;

            when GlobaleKonstanten.SpeichernKonstante => -- Speichern
               GlobaleVariablen.RasseAmZugNachLaden := RasseExtern;
               Speichern.SpeichernNeu (AutospeichernExtern => False);
               
            when GlobaleKonstanten.LadenKonstante => -- Laden
               LadenErfolgreich := Laden.LadenNeu;
               case LadenErfolgreich is
                  when True =>
                     return -300;

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
               return AktuellerBefehlSpieler;

            when -1_000 => -- Runde beenden
               return GlobaleKonstanten.StartNormalKonstante;      
                  
            when others =>
               Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseExtern);
         end case;
                     
      end loop SpielerSchleife;
      
   end MenschlicherSpieler;



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
      Ladezeiten.BerechnungenNachZugendeAllerSpieler (WelcheZeitExtern => 1);
      
   end BerechnungenNachZugendeAllerSpieler;

end ImSpiel;
