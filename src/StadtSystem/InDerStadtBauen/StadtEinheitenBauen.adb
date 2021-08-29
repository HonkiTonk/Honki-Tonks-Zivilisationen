pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleTexte;

with KIDatentypen;

with SchreibeStadtGebaut;
with LeseEinheitenGebaut, LeseStadtGebaut;

with Anzeige, Eingabe, Karte, EinheitSuchen, EinheitenAllgemein, UmgebungErreichbarTesten, StadtMeldungenSetzen;

package body StadtEinheitenBauen is

   procedure EinheitFertiggestellt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      EinheitNummer := 0;
            
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze loop
            
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert))
         is
            when GlobaleKonstanten.LeerEinheitenID =>
               EinheitNummer := EinheitNummerSchleifenwert;
               exit EinheitenSchleife;
            
            when others =>
               null;
         end case;
            
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
        EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern)).Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
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
