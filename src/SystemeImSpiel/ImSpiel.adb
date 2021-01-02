package body ImSpiel is

   function ImSpiel return Integer is -- Karte.Sichtbarkeit von hier nach BefehleImSpiel verschiebbar?
   begin
     
      ErsteRunde := True;

      SpielSchleife:
      loop
         
         RassenSchleife:
         for Rasse in GlobaleVariablen.RassenImSpiel'Range loop
            
            GlobaleVariablen.GeradeAmZug := Rasse;

            case ErsteRunde is
               when True =>
                  Sichtbarkeit.Sichtbarkeitsprüfung;

               when False =>
                  null;
            end case;
            
            case GlobaleVariablen.RassenImSpiel (Rasse) is -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
               when 0 =>
                  null;
                  
               when 1 =>
                  SpielerSchleife:
                  loop
                     
                     Karte.AnzeigeKarte;
                     AktuellerBefehl := BefehleImSpiel.Befehle (Rasse => Rasse);
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
               
                        when 0 =>
                           return 0;

                        when -1 =>
                           return -1;

                        when -1_000 => -- Runde beenden
                           exit SpielerSchleife;      
                  
                        when others =>
                           Sichtbarkeit.Sichtbarkeitsprüfung;
                     end case;
                     
                  end loop SpielerSchleife;
                  
               when others =>
                  KI.KI (Rasse => Rasse);
            end case;
            
         end loop RassenSchleife;

         ErsteRunde := False;
                       
         EinheitenDatenbank.HeilungBewegungspunkteFürNeueRundeSetzen;
         Verbesserungen.VerbesserungFertiggestellt;
         Wachstum.Wachstum;
         Bauen.BauzeitAlle;
         InDerStadt.StadtProduktionPrüfen (0, 0);
         ForschungsDatenbank.ForschungFortschritt;
         GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;
         Sichtbarkeit.Sichtbarkeitsprüfung;
         Karte.AnzeigeKarte;
         -- Speichern.AutoSpeichern;             
                     
      end loop SpielSchleife;
            
   end ImSpiel;

end ImSpiel;
