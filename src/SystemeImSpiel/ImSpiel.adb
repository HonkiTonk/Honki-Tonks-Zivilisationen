package body ImSpiel is

   function ImSpiel return Integer is -- Karte.Sichtbarkeit von hier nach BefehleImSpiel verschiebbar?
   begin

      Sichtbarkeit.Sichtbarkeitsprüfung;
      Karte.AnzeigeKarte;

      SpielSchleife:
      loop
         
         AktuellerBefehl := BefehleImSpiel.Befehle;
         case AktuellerBefehl is
            when 1 =>
               Karte.AnzeigeKarte;

            when 2 => -- Speichern
               Speichern.Speichern (AutoSpeichern => False);
               Karte.AnzeigeKarte;
               
            when 3 => -- Laden
               Laden.Laden;
               Karte.AnzeigeKarte;
               
            when 4 =>
               Optionen.Optionen;
               Karte.AnzeigeKarte;
               
            when 0 =>
               return 0;

            when -1 =>
               return -1;

            when -1000 => -- Runde beenden
                          -- KI Züge hier einbauen
               EinheitenDatenbank.HeilungBewegungspunkteFürNeueRundeSetzen;
               VerbesserungenDatenbank.VerbesserungFertiggestellt (Rasse => GlobaleVariablen.Rasse);
               Wachstum.Wachstum;
               Bauen.Bauzeit (Rasse => GlobaleVariablen.Rasse);
               InDerStadt.StadtProduktionPrüfen (0, 0);
               ForschungsDatenbank.ForschungFortschritt;
               GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;
               Sichtbarkeit.Sichtbarkeitsprüfung;
               Karte.AnzeigeKarte;
               Speichern.AutoSpeichern;
               
            when others =>
               Sichtbarkeit.Sichtbarkeitsprüfung;
               Karte.AnzeigeKarte;
         end case;
         
      end loop SpielSchleife;
            
   end ImSpiel;

end ImSpiel;
