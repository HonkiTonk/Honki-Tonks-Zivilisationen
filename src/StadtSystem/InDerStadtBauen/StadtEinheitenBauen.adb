pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleTexte;

with KIDatentypen;

with Anzeige, Eingabe, Karte, EinheitSuchen, EinheitenAllgemein, UmgebungErreichbarTesten, StadtMeldungenSetzen, LeseEinheitenGebaut, LeseStadtGebaut, SchreibeStadtGebaut;

package body StadtEinheitenBauen is

   procedure EinheitFertiggestellt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      EinheitNummer := 0;
            
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze loop
            
         if
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert)) = GlobaleKonstanten.LeerEinheit.ID
         then
            EinheitNummer := EinheitNummerSchleifenwert;
            exit EinheitenSchleife;
            
         else
            null;
         end if;
            
      end loop EinheitenSchleife;
      
      -- Hier noch Meldungsnutzung einbauen
      if
        EinheitNummer = 0
        and
          GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                               TextZeileExtern => 19);
         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position := LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern);
         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionAlt := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position;
         Karte.AnzeigeKarte (RasseExtern => StadtRasseNummerExtern.Rasse);         
         Eingabe.WartenEingabe;
         return;
         
      elsif
        EinheitNummer = 0
      then
         return;
         
      else
         null;
      end if;
            
      if
        EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern)).Platznummer
          = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         KartenWert := LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
      else
         KartenWert := UmgebungErreichbarTesten.UmgebungErreichbarTesten (AktuelleKoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                          RasseExtern               => StadtRasseNummerExtern.Rasse,
                                                                          IDExtern                  => GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut
                                                                            (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt - GlobaleKonstanten.EinheitAufschlag),
                                                                          NotwendigeFelderExtern    => 1);
      end if;
        
      case
        KartenWert.XAchse
      is
         when GlobaleKonstanten.LeerYXKartenWert =>
            StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => GlobaleDatentypen.Einheit_Unplatzierbar);
            
         when others =>
            EinheitenAllgemein.EinheitErzeugen (KoordinatenExtern      => KartenWert,
                                                EinheitNummerExtern    => EinheitNummer,
                                                IDExtern               => GlobaleDatentypen.EinheitenID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - GlobaleKonstanten.EinheitAufschlag),
                                                StadtRasseNummerExtern => StadtRasseNummerExtern);
            SchreibeStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauzeitExtern          => GlobaleKonstanten.LeerStadt.Bauzeit,
                                         ÄndernSetzenExtern     => False);
            SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                            RessourcenExtern       => GlobaleKonstanten.LeerStadt.Ressourcen,
                                            ÄndernSetzenExtern     => False);
            SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                            BauprojektExtern       => GlobaleKonstanten.LeerStadt.Bauprojekt);
            
            if
              GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
            then
               StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                EreignisExtern         => GlobaleDatentypen.Produktion_Abgeschlossen);
         
            else
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern    => KIDatentypen.Keine_Aufgabe);
            end if;
      end case;
      
   end EinheitFertiggestellt;

end StadtEinheitenBauen;
