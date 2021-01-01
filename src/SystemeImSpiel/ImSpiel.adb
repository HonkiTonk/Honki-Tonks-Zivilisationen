package body ImSpiel is

   function ImSpiel return Integer is -- Karte.Sichtbarkeit von hier nach BefehleImSpiel verschiebbar?
   begin

      Sichtbarkeit.Sichtbarkeitsprüfung;
      Karte.AnzeigeKarte;

      SpielSchleife:
      loop
         
         RassenSchleife:
         for Rasse in GlobaleVariablen.RassenImSpiel'Range loop
            
            case GlobaleVariablen.RassenImSpiel (Rasse) is -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
               when 0 =>
                  null;
                  
               when 1 =>
                  SpielerSchleife:
                  loop
                     
                     AktuellerBefehl := BefehleImSpiel.Befehle (Rasse => Rasse);
                     case AktuellerBefehl is
                        when 1 =>
                           Karte.AnzeigeKarte;

                        when 2 => -- Speichern
                           -- Speichern.Speichern (AutoSpeichern => False);
                           Karte.AnzeigeKarte;
               
                        when 3 => -- Laden
                           -- Laden.Laden;
                           Karte.AnzeigeKarte;
               
                        when 4 =>
                           Optionen.Optionen;
                           Karte.AnzeigeKarte;
               
                        when 0 =>
                           return 0;

                        when -1 =>
                           return -1;

                        when -1000 => -- Runde beenden
                           exit SpielerSchleife;      
                  
                        when others =>
                           Sichtbarkeit.Sichtbarkeitsprüfung;
                           Karte.AnzeigeKarte;
                     end case;
                     
                  end loop SpielerSchleife;
                  
               when others =>
                  KI.KI (Rasse => Rasse);
            end case;
            
         end loop RassenSchleife;
                       
         EinheitenDatenbank.HeilungBewegungspunkteFürNeueRundeSetzen;
         Verbesserungen.VerbesserungFertiggestellt (Rasse => GlobaleVariablen.Rasse);
         Wachstum.Wachstum;
         Bauen.Bauzeit (Rasse => GlobaleVariablen.Rasse);
         InDerStadt.StadtProduktionPrüfen (0, 0);
         ForschungsDatenbank.ForschungFortschritt;
         GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;
         Sichtbarkeit.Sichtbarkeitsprüfung;
         Karte.AnzeigeKarte;
         -- Speichern.AutoSpeichern;             
                     
      end loop SpielSchleife;
            
   end ImSpiel;

end ImSpiel;
