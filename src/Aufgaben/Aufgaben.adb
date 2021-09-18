pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen;

with SchreibeKarten, SchreibeEinheitenGebaut, SchreibeWichtiges;
with LeseKarten, LeseEinheitenGebaut, LeseEinheitenDatenbank, LeseWichtiges;

with FelderwerteFestlegen, EinheitenMeldungenSetzen, EinheitenBeschreibungen, EinheitenErzeugenEntfernen, EinheitenModifizieren, VerbesserungWeg, VerbesserungMine, VerbesserungRoden, VerbesserungFarm, VerbesserungFestung,
     VerbesserungWald, AufgabenAllgemein;

package body Aufgaben is
   
   function VerbesserungTesten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in GlobaleDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
   is begin
      
      case
        AllgemeinerAnfangstest (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                BefehlExtern             => BefehlExtern)
      is
         when True =>
            return VerbesserungFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => BefehlExtern,
                                           AnlegenTestenExtern      => False);
            
         when False =>
            return False;
      end case;
      
   end VerbesserungTesten;
   
   
   
   function VerbesserungAnlegen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in GlobaleDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
   is begin
      
      case
        AllgemeinerAnfangstest (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                BefehlExtern             => BefehlExtern)
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
     
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Leer
        or
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         return VerbesserungFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        BefehlExtern             => BefehlExtern,
                                        AnlegenTestenExtern      => True);
         
      else
         case
           EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 7)
         is
            when True =>
               return VerbesserungFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BefehlExtern             => BefehlExtern,
                                              AnlegenTestenExtern      => True);
                     
            when False =>
               return False;
         end case;
      end if;
   
   end VerbesserungAnlegen;
   
   
   
   function AllgemeinerAnfangstest
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in GlobaleDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
   is begin
      
      if
        GlobaleKonstanten.TechnologieVerbesserung (EinheitRasseNummerExtern.Rasse, BefehlExtern) = -1
      then
         return False;

      elsif
        GlobaleKonstanten.TechnologieVerbesserung (EinheitRasseNummerExtern.Rasse, BefehlExtern) = 0
      then
         null;

      elsif
        LeseWichtiges.Erforscht (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => GlobaleKonstanten.TechnologieVerbesserung (EinheitRasseNummerExtern.Rasse, BefehlExtern))
          = True
      then
         null;
         
      else
         return False;
      end if;
      
      if
        BefehlExtern in GlobaleDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range
        and
          LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
            /= GlobaleDatentypen.Arbeiter
      then
         return False;
         
      elsif
        BefehlExtern = GlobaleDatentypen.Plündern
        and
          LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
            = GlobaleDatentypen.Arbeiter
      then
         return False;
         
      else
         null;
      end if;
      
      return True;
      
   end AllgemeinerAnfangstest;
   


   function VerbesserungFestgelegt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in GlobaleDatentypen.Tastenbelegung_Befehle_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Grund := LeseKarten.Grund (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        BefehlExtern
      is
         when GlobaleDatentypen.Straße_Bauen =>
            return VerbesserungWeg.VerbesserungWeg (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    GrundExtern              => Grund,
                                                    AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when GlobaleDatentypen.Mine_Bauen =>
            return VerbesserungMine.VerbesserungMine (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      GrundExtern              => Grund,
                                                      AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when GlobaleDatentypen.Farm_Bauen =>
            return VerbesserungFarm.VerbesserungFarm (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      GrundExtern              => Grund,
                                                      AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when GlobaleDatentypen.Festung_Bauen =>
            return VerbesserungFestung.VerbesserungFestung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            GrundExtern              => Grund,
                                                            AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when GlobaleDatentypen.Wald_Aufforsten =>
            return VerbesserungWald.VerbesserungWald (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      GrundExtern              => Grund,
                                                      AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when GlobaleDatentypen.Roden_Trockenlegen =>
            return VerbesserungRoden.VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        GrundExtern              => Grund,
                                                        AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when GlobaleDatentypen.Heilen =>
            return EinheitHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                  AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when GlobaleDatentypen.Verschanzen =>
            EinheitVerschanzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when GlobaleDatentypen.Runde_Aussetzen =>
            RundeAussetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when GlobaleDatentypen.Einheit_Auflösen =>
            EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when GlobaleDatentypen.Plündern =>
            if
              LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) /= GlobaleDatentypen.Leer
              or
                LeseKarten.VerbesserungWeg (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) /= GlobaleDatentypen.Leer
            then
               return VerbesserungPlündern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             AnlegenTestenExtern      => AnlegenTestenExtern);
               
            else
               return False;
            end if;
         
         when GlobaleDatentypen.Einheit_Verbessern =>
            return VerbesserungEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        AnlegenTestenExtern      => AnlegenTestenExtern);
      end case;
      
      return True;
      
   end VerbesserungFestgelegt;
   
   
   
   function EinheitHeilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        = LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      then
         return False;
         
      else
         SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 BeschäftigungExtern     => GlobaleDatentypen.Heilen);
      end if;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Leer);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => GlobaleKonstanten.LeerEinheit.Beschäftigungszeit,
                                                         RechnenSetzenExtern      => 0);
      end case;
      
      return True;
      
   end EinheitHeilen;
   
   
   
   procedure EinheitVerschanzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => GlobaleDatentypen.Verschanzen);
      
   end EinheitVerschanzen;
   
   
   
   procedure RundeAussetzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               BewegungspunkteExtern    => GlobaleKonstanten.LeerEinheit.Bewegungspunkte,
                                               RechnenSetzenExtern      => 0);
      
   end RundeAussetzen;
   
   
   
   procedure EinheitAuflösen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
        and then
          EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 9) = True
      then
         EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
        and then
          EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 9) = False
      then
         null;
         
      else
         EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end EinheitAuflösen;
   
   
   
   function VerbesserungPlündern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
            
      if
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = GlobaleDatentypen.Leer
        and
          LeseKarten.VerbesserungWeg (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = GlobaleDatentypen.Leer
      then
         return False;
         
      elsif
        AnlegenTestenExtern = False
      then
         return True;
         
      else
         null;
      end if;
      
      if
        (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
         and then
         EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 12) = True)
        or
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         null;
                     
      else
         return False;
      end if;
      
      case
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            SchreibeKarten.VerbesserungGebiet (PositionExtern     => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               VerbesserungExtern => GlobaleDatentypen.Leer);
            SchreibeWichtiges.Geldmenge (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                         GeldZugewinnExtern  => 10,
                                         RechnenSetzenExtern => True);
      end case;
      
      case
        LeseKarten.VerbesserungWeg (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                            WegExtern      => GlobaleDatentypen.Leer);
            SchreibeWichtiges.Geldmenge (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                         GeldZugewinnExtern  => 5,
                                         RechnenSetzenExtern => True);
      end case;
      
      return True;
      
   end VerbesserungPlündern;
   
   
   
   function VerbesserungEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                 IDExtern    => IDEinheit)
        = GlobaleDatentypen.EinheitenIDMitNullWert'First
        or
          LeseKarten.BelegterGrund (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                    KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
            = False
      then
         return False;
         
      elsif
        LeseWichtiges.Erforscht (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern =>  LeseEinheitenDatenbank.Anforderungen (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                   IDExtern    => LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                                           IDExtern    => IDEinheit)))
        = False
      then
         return False;
         
      else
         null;
      end if;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                                    
         when False =>
            null;
      end case;
      
      return True;
      
   end VerbesserungEinheit;
   
   
   
   procedure EinheitVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               BewegungspunkteExtern    => GlobaleKonstanten.LeerEinheit.Bewegungspunkte,
                                               RechnenSetzenExtern      => 0);
      
      EinheitenModifizieren.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     VorzeichenWechselExtern  => -1);
      
      SchreibeEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                  IDExtern                 => LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                       IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      EinheitenModifizieren.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     VorzeichenWechselExtern  => 1);
      
   end EinheitVerbessern;
   


   procedure VerbesserungFertiggestellt
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
         
                  case
                    LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert))
                  is
                     when GlobaleKonstanten.LeerEinheitenID =>
                        null;

                     when others =>
                        VerbesserungFertiggestelltPrüfen (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert));
                  end case;
                  
               end loop EinheitenSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end VerbesserungFertiggestellt;



   procedure VerbesserungFertiggestelltPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when GlobaleDatentypen.Leer | GlobaleDatentypen.Heilen | GlobaleDatentypen.Verschanzen =>
            return;
               
         when others =>
            null;
      end case;

      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => 1,
                                                   RechnenSetzenExtern      => -1);
      
      if
        LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleKonstanten.LeerEinheit.Beschäftigungszeit
      then
         EinheitenMeldungenSetzen.EinheitMeldungSetzenEreignis (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                EreignisExtern           => GlobaleDatentypen.Aufgabe_Abgeschlossen);
         VerbesserungAngelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         case
           LeseEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when GlobaleDatentypen.Leer =>
               SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       AufgabeExtern            => KIDatentypen.Tut_Nichts);
               AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

            when others =>
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => LeseEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
               SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            ZeitExtern               => LeseEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                            RechnenSetzenExtern      => 0);
               SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BeschäftigungExtern     => GlobaleDatentypen.Leer);
               SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                      ZeitExtern               => GlobaleKonstanten.LeerEinheit.BeschäftigungszeitNachfolger,
                                                                      RechnenSetzenExtern      => 0);
         end case;
         
      else
         null;
      end if;
      
   end VerbesserungFertiggestelltPrüfen;



   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when GlobaleDatentypen.Straße_Bauen =>
            VerbesserungWeg.WegBerechnen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
              
         when GlobaleDatentypen.Mine_Bauen =>
            SchreibeKarten.VerbesserungGebiet (PositionExtern     => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               VerbesserungExtern => GlobaleDatentypen.Mine);
            
         when GlobaleDatentypen.Farm_Bauen =>
            SchreibeKarten.VerbesserungGebiet (PositionExtern     => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               VerbesserungExtern => GlobaleDatentypen.Farm);
            
         when GlobaleDatentypen.Festung_Bauen =>
            SchreibeKarten.VerbesserungGebiet (PositionExtern     => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               VerbesserungExtern => GlobaleDatentypen.Festung);
              
         when GlobaleDatentypen.Wald_Aufforsten =>
            VerbesserungWaldAufforsten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
              
         when GlobaleDatentypen.Roden_Trockenlegen =>
            if
              LeseKarten.Hügel (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True
            then
               SchreibeKarten.Grund (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                     GrundExtern    => GlobaleDatentypen.Hügel);
                  
            else
               SchreibeKarten.Grund (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                     GrundExtern    => GlobaleDatentypen.Flachland);
            end if;
            
         when others =>
            null;
      end case;

      FelderwerteFestlegen.EinzelnesKartenfeldBewerten (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end VerbesserungAngelegt;
   
   
   
   procedure VerbesserungWaldAufforsten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseKarten.Grund (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = GlobaleDatentypen.Hügel
      then
         SchreibeKarten.Hügel (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                HügelExtern   => True);
               
      else
         null;
      end if;
            
      SchreibeKarten.Grund (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                            GrundExtern    => GlobaleDatentypen.Wald);
      
      if
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        GlobaleDatentypen.Karten_Verbesserung_Gebilde_Friedlich_Enum'Range
      then
         SchreibeKarten.VerbesserungGebiet (PositionExtern     => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                            VerbesserungExtern => GlobaleDatentypen.Leer);
                  
      else
         null;
      end if;
      
   end VerbesserungWaldAufforsten;

end Aufgaben;
