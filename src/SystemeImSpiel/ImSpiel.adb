package body ImSpiel is

   function ImSpiel return Integer is
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
               ErfolgreichGeladenGespeichert := Laden.Laden;
               case ErfolgreichGeladenGespeichert is
                  when True =>
                     null;
                     
                  when False =>
                     Ausgabe.Fehlermeldungen (WelcheFehlermeldung => 10);
               end case;
               
            when 3 => -- Laden
               ErfolgreichGeladenGespeichert := Laden.Laden;
               case ErfolgreichGeladenGespeichert is
                  when True =>
                     null;
                     
                  when False =>
                     Ausgabe.Fehlermeldungen (WelcheFehlermeldung => 9);
                     return 0;
               end case;
               
            when 4 =>
               Optionen.Optionen;
               
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
               ForschungsDatenbank.Forschung;
               GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;
               Sichtbarkeit.Sichtbarkeitsprüfung;
               Karte.AnzeigeKarte;
               
            when others =>
               Sichtbarkeit.Sichtbarkeitsprüfung;
               Karte.AnzeigeKarte;
         end case;
         
      end loop SpielSchleife;
            
   end ImSpiel;

end ImSpiel;
