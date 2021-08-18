pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleTexte;

with KIDatentypen;

with Anzeige, Eingabe, Karte, EinheitSuchen, EinheitenAllgemein, UmgebungErreichbarTesten, StadtMeldungenSetzen, LeseEinheitenGebaut;

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
         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position;
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
        EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position).Platznummer
          = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         KartenWert := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position;
         
      else
         KartenWert := UmgebungErreichbarTesten.UmgebungErreichbarTesten (AktuelleKoordinatenExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
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
                                                IDExtern               => GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                  StadtRasseNummerExtern.Platznummer).Bauprojekt - GlobaleKonstanten.EinheitAufschlag),
                                                StadtRasseNummerExtern => StadtRasseNummerExtern);
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit := 0;
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := 0;
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := 0;
            
            if
              GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
            then
               StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                EreignisExtern         => GlobaleDatentypen.Produktion_Abgeschlossen);
         
            else
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung := KIDatentypen.Keine_Aufgabe;
            end if;
      end case;
      
   end EinheitFertiggestellt;

end StadtEinheitenBauen;
