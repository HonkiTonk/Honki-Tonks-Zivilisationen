pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;

with KIDatentypen;

with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with Anzeige;
with Eingabe;
with Karte;
with EinheitSuchen;
with UmgebungErreichbarTesten;
with StadtMeldungenSetzen;
with EinheitenErzeugenEntfernen;

package body StadtEinheitenBauen is

   procedure EinheitFertiggestellt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      EinheitNummer := 0;
            
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze loop
            
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               EinheitNummer := EinheitNummerSchleifenwert;
               exit EinheitenSchleife;
            
            when others =>
               null;
         end case;
            
      end loop EinheitenSchleife;
      
      if
        EinheitNummer = EinheitenKonstanten.LeerNummer
        and
          GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_Mensch
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                               TextZeileExtern => 19);
         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position := LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern);
         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionAlt := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position;
         Karte.AnzeigeKarte (RasseExtern => StadtRasseNummerExtern.Rasse);
         Eingabe.WartenEingabe;
         
      elsif
        EinheitNummer = EinheitenKonstanten.LeerNummer
      then
         null;
         
      else
         PlatzErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end if;
      
   end EinheitFertiggestellt;
   
   
   
   procedure PlatzErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern)).Platznummer = EinheitenKonstanten.LeerNummer
      then
         KartenWert := LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
      else
         KartenWert := UmgebungErreichbarTesten.UmgebungErreichbarTesten (AktuelleKoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                          RasseExtern               => StadtRasseNummerExtern.Rasse,
                                                                          IDExtern                  => EinheitStadtDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut
                                                                            (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt - EinheitenKonstanten.EinheitAufschlag),
                                                                          NotwendigeFelderExtern    => 1);
      end if;
        
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => EinheitStadtDatentypen.Einheit_Unplatzierbar);
            
         when others =>
            EinheitPlatzieren (StadtRasseNummerExtern => StadtRasseNummerExtern,
                               KoordinatenExtern      => KartenWert);
      end case;
      
   end PlatzErmitteln;
   
   
   
   procedure EinheitPlatzieren
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
     KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      EinheitenErzeugenEntfernen.EinheitErzeugen (KoordinatenExtern      => KoordinatenExtern,
                                                  EinheitNummerExtern    => EinheitNummer,
                                                  IDExtern               => 
                                                    EinheitStadtDatentypen.EinheitenID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - EinheitenKonstanten.EinheitAufschlag),
                                                  StadtRasseNummerExtern => StadtRasseNummerExtern);
      SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      RessourcenExtern       => StadtKonstanten.LeerStadt.Ressourcen,
                                      ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      BauprojektExtern       => StadtKonstanten.LeerStadt.Bauprojekt);
            
      case
        GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse)
      is
         when SystemDatentypen.Spieler_Mensch =>
            StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => EinheitStadtDatentypen.Produktion_Abgeschlossen);
         
         when others =>
            SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                  BeschäftigungExtern    => KIDatentypen.Keine_Aufgabe);
      end case;
      
   end EinheitPlatzieren;

end StadtEinheitenBauen;
