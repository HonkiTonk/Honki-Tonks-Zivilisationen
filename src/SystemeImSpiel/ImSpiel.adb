package body ImSpiel is

   function ImSpiel return Integer is -- Karte.Sichtbarkeit von hier nach BefehleImSpiel verschiebbar?
   begin
     
      SpielSchleife:
      loop
         
         RassenSchleife:
         for RasseIntern in GlobaleVariablen.RassenImSpiel'Range loop
            
            case GlobaleVariablen.RassenImSpiel (RasseIntern) is
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
                                  -- Speichern.Speichern (AutoSpeichern => False);
                           null;
               
                        when 3 => -- Laden
                                  -- Laden.Laden;
                           null;
               
                        when 4 =>
                           Optionen.Optionen;
                           null;
               
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
            
         end loop RassenSchleife;
                  
         Ladezeiten.BerechnungenNachZugendeAllerSpielerZeiten (1, 1) := Clock;
         EinheitenDatenbank.HeilungBewegungspunkteFürNeueRundeSetzen;
         Verbesserungen.VerbesserungFertiggestellt;
         Wachstum.Wachstum;
         Bauen.BauzeitAlle;
         InDerStadt.StadtProduktionPrüfen (0, 0);
         ForschungsDatenbank.ForschungFortschritt;
         GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;
         -- Speichern.AutoSpeichern;          
         Ladezeiten.BerechnungenNachZugendeAllerSpielerZeiten (2, 1) := Clock;
         Ladezeiten.BerechnungenNachZugendeAllerSpieler (WelcheZeit => 1);
                     
      end loop SpielSchleife;
            
   end ImSpiel;

end ImSpiel;
