pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen;

with FelderwerteFestlegen, KartePositionPruefen, EinheitenAllgemein, WichtigesSetzen, EinheitenMeldungenSetzen, LeseKarten, SchreibeKarten, LeseEinheitenGebaut, SchreibeEinheitenGebaut, LeseEinheitenDatenbank;

package body Verbesserungen is
   
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
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Nicht_Vorhanden
        or
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         return VerbesserungFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        BefehlExtern             => BefehlExtern,
                                        AnlegenTestenExtern      => True);
         
      else
         case
           EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 7)
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
        GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (GlobaleKonstanten.TechnologieVerbesserung (EinheitRasseNummerExtern.Rasse, BefehlExtern)) = True
      then
         null;
         
      else
         return False;
      end if;
      
      if
        BefehlExtern in GlobaleDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range
        and
          LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) /= GlobaleDatentypen.Arbeiter
      then
         return False;
         
      elsif
        BefehlExtern = GlobaleDatentypen.Plündern
        and
          LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = GlobaleDatentypen.Arbeiter
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
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => 0,
                                                   RechnenSetzenExtern      => 0);
      SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
      SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             ZeitExtern               => 0,
                                                             RechnenSetzenExtern      => 0);

      Grund := LeseKarten.Grund (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        BefehlExtern
      is
         when GlobaleDatentypen.Straße_Bauen =>
            return VerbesserungWeg (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                    GrundExtern              => Grund,
                                    AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when GlobaleDatentypen.Mine_Bauen =>
            return VerbesserungMine (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     GrundExtern              => Grund,
                                     AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when GlobaleDatentypen.Farm_Bauen =>
            return VerbesserungFarm (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     GrundExtern              => Grund,
                                     AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when GlobaleDatentypen.Festung_Bauen =>
            return VerbesserungFestung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        GrundExtern              => Grund,
                                        AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when GlobaleDatentypen.Wald_Aufforsten =>
            return VerbesserungWald (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     GrundExtern              => Grund,
                                     AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when GlobaleDatentypen.Roden_Trockenlegen =>
            return VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
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



   -- Hier prüfen welcher Weg
   function VerbesserungWeg
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      if
        LeseKarten.VerbesserungWeg (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        GlobaleDatentypen.Karten_Verbesserung_Weg_Enum'Range
      then
         return False;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Flachland | GlobaleDatentypen.Tundra | GlobaleDatentypen.Wüste | GlobaleDatentypen.Hügel | GlobaleDatentypen.Wald
            | GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Straße_Bauen);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when GlobaleDatentypen.Gebirge | GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Straße_Bauen);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 6,
                                                         RechnenSetzenExtern      => 0);
               
         when others =>
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => GlobaleKonstanten.LeerEinheit.Beschäftigungszeit,
                                                         RechnenSetzenExtern      => 0);
      end case;
      
      return True;
      
   end VerbesserungWeg;
   
   
   
   function VerbesserungMine
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      if
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = GlobaleDatentypen.Mine
      then
         return False;

      elsif
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        GlobaleDatentypen.Karten_Verbesserung_Gebilde_Enum'Range
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
      then
         case
           EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8)
         is
            when True =>
               null;
                     
            when False =>
               return False;
         end case;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Flachland | GlobaleDatentypen.Tundra | GlobaleDatentypen.Wüste | GlobaleDatentypen.Hügel
            | GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range | GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Mine_Bauen);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when GlobaleDatentypen.Gebirge =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Mine_Bauen);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 5,
                                                         RechnenSetzenExtern      => 0);

         when GlobaleDatentypen.Wald | GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            if
              VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 GrundExtern              => GrundExtern,
                                 AnlegenTestenExtern      => AnlegenTestenExtern) = True
            then
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => GlobaleDatentypen.Mine_Bauen);
               SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            ZeitExtern               => 3,
                                                            RechnenSetzenExtern      => 0);
               
            else
               return False;
            end if;
               
         when others =>
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => GlobaleKonstanten.LeerEinheit.Beschäftigungszeit,
                                                         RechnenSetzenExtern      => 0);
      end case;
      
      return True;
      
   end VerbesserungMine;

   
   
   function VerbesserungFarm
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin

      if
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = GlobaleDatentypen.Farm
      then
         return False;

      elsif
        LeseKarten.Grund (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = GlobaleDatentypen.Eis
      then
         return False;

      elsif
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) 
      in
        GlobaleDatentypen.Karten_Verbesserung_Gebilde_Enum'Range
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
      then
         case
           EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8)
         is
            when True =>
               null;
               
            when False =>
               return False;
         end case;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when GlobaleDatentypen.Flachland | GlobaleDatentypen.Tundra | GlobaleDatentypen.Wüste | GlobaleDatentypen.Hügel
            | GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range | GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Farm_Bauen);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when GlobaleDatentypen.Gebirge =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Farm_Bauen);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 5,
                                                         RechnenSetzenExtern      => 0);

         when GlobaleDatentypen.Wald | GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            if
              VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 GrundExtern              => GrundExtern,
                                 AnlegenTestenExtern      => AnlegenTestenExtern) = True
            then
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => GlobaleDatentypen.Farm_Bauen);
               SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            ZeitExtern               => 3,
                                                            RechnenSetzenExtern      => 0);
               
            else
               return False;
            end if;
               
         when others =>
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => GlobaleKonstanten.LeerEinheit.Beschäftigungszeit,
                                                         RechnenSetzenExtern      => 0);
      end case;
      
      return True;
      
   end VerbesserungFarm;
   
   
   
   function VerbesserungFestung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
            
      if
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = GlobaleDatentypen.Festung
      then
         return False;

      elsif
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        GlobaleDatentypen.Karten_Verbesserung_Gebilde_Enum'Range
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
      then
         case
           EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8)
         is
            when True =>
               null;
                     
            when False =>
               return False;
         end case;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Flachland | GlobaleDatentypen.Tundra | GlobaleDatentypen.Wüste | GlobaleDatentypen.Hügel | GlobaleDatentypen.Wald | GlobaleDatentypen.Dschungel
            | GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range | GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Festung_Bauen);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when GlobaleDatentypen.Gebirge =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Festung_Bauen);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 5,
                                                         RechnenSetzenExtern      => 0);
               
         when others =>
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => GlobaleKonstanten.LeerEinheit.Beschäftigungszeit,
                                                         RechnenSetzenExtern      => 0);
      end case;
      
      return True;
      
   end VerbesserungFestung;
   
   
   
   function VerbesserungWald
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      if
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = GlobaleDatentypen.Farm
        or
          LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = GlobaleDatentypen.Mine
      then
         if
           GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
           and then
             EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8) = True
         then
            null;
            
         elsif
           GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
           and then
             EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8) = False
         then
            return False;
            
         else
            null;
         end if;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when GlobaleDatentypen.Flachland | GlobaleDatentypen.Hügel | GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range | GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Wald_Aufforsten);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            if
              VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 GrundExtern              => GrundExtern,
                                 AnlegenTestenExtern      => AnlegenTestenExtern) = True
            then
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => GlobaleDatentypen.Wald_Aufforsten);
               SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            ZeitExtern               => 3,
                                                            RechnenSetzenExtern      => 0);
            
            else
               return False;
            end if;
               
         when others =>
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => GlobaleKonstanten.LeerEinheit.Beschäftigungszeit,
                                                         RechnenSetzenExtern      => 0);
      end case;
      
      return True;
      
   end VerbesserungWald;
   
   
   
   function VerbesserungRoden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      case
        GrundExtern
      is
         when GlobaleDatentypen.Wald | GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Roden_Trockenlegen);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);
              
         when others =>
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => GlobaleKonstanten.LeerEinheit.Beschäftigungszeit,
                                                         RechnenSetzenExtern      => 0);
      end case;
      
      return True;
      
   end VerbesserungRoden;
   
   
   
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
                                                    BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
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
          EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 9) = True
      then
         EinheitenAllgemein.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
        and then
          EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 9) = False
      then
         null;
         
      else
         EinheitenAllgemein.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
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
         EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 12) = True)
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
            WichtigesSetzen.GeldFestlegen (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                           GeldZugewinnExtern => 10);
      end case;
      
      case
        LeseKarten.VerbesserungWeg (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                            WegExtern      => GlobaleDatentypen.Leer);
            WichtigesSetzen.GeldFestlegen (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                           GeldZugewinnExtern => 5);
      end case;
      
      return True;
      
   end VerbesserungPlündern;
   
   
   
   function VerbesserungEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      if
        LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                 IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = GlobaleDatentypen.EinheitenIDMitNullWert'First
        or
          LeseKarten.BelegterGrund (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                    KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = False
      then
         return False;
         
      elsif
        GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht
        (LeseEinheitenDatenbank.Anforderungen (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                               IDExtern    => LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                       IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)))) = False
      then
         return False;
         
      else
         null;
      end if;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     BewegungspunkteExtern    => GlobaleKonstanten.LeerEinheit.Bewegungspunkte,
                                                     RechnenSetzenExtern      => 0);
            SchreibeEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        IDExtern                 => LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
                        
         when False =>
            null;
      end case;
      
      return True;
      
   end VerbesserungEinheit;
   


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
         when GlobaleDatentypen.Nicht_Vorhanden | GlobaleDatentypen.Heilen | GlobaleDatentypen.Verschanzen =>
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
            when GlobaleDatentypen.Nicht_Vorhanden =>
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
               SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       AufgabeExtern            => KIDatentypen.Keine_Aufgabe);
               SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            ZeitExtern               => GlobaleKonstanten.LeerEinheit.Beschäftigungszeit,
                                                            RechnenSetzenExtern      => 0);

            when others =>
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => LeseEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
               SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            ZeitExtern               => LeseEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                            RechnenSetzenExtern      => 0);
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
               SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
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
            StraßeBerechnung (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
              
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



   procedure StraßeBerechnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin

      Wegewert := 10_000;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              XÄnderungSchleifenwert = -1
              and
                YÄnderungSchleifenwert = 0
            then
               case
                 LeseKarten.VerbesserungWeg (PositionExtern => KartenWert)
               is
                  when GlobaleDatentypen.Leer =>
                     Wegewert := Wegewert - 1_000;

                  when GlobaleDatentypen.Straße_Senkrecht =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Rechts);
                     
                  when GlobaleDatentypen.Straßenkurve_Unten_Links =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Unten);

                  when GlobaleDatentypen.Straßenkurve_Oben_Links =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Oben);

                  when GlobaleDatentypen.Straßenkreuzung_Drei_Links =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Vier);

                  when GlobaleDatentypen.Straßenendstück_Rechts =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straße_Waagrecht);

                  when GlobaleDatentypen.Straßenendstück_Unten =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkurve_Oben_Rechts);

                  when GlobaleDatentypen.Straßenendstück_Oben =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkurve_Unten_Rechts);
                     
                  when GlobaleDatentypen.Straße_Einzeln =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenendstück_Links);
                     
                  when others =>
                     null;
               end case;
               Wegewert := Wegewert + 1_000;
               
            elsif
              XÄnderungSchleifenwert = 1
              and
                YÄnderungSchleifenwert = 0
            then
               case
                 LeseKarten.VerbesserungWeg (PositionExtern => KartenWert)
               is
                  when GlobaleDatentypen.Leer =>
                     Wegewert := Wegewert - 100;

                  when GlobaleDatentypen.Straße_Senkrecht =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Links);
                     
                  when GlobaleDatentypen.Straßenkurve_Unten_Rechts =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Unten);

                  when GlobaleDatentypen.Straßenkurve_Oben_Rechts =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Oben);

                  when GlobaleDatentypen.Straßenkreuzung_Drei_Rechts =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Vier);

                  when GlobaleDatentypen.Straßenendstück_Links =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straße_Waagrecht);

                  when GlobaleDatentypen.Straßenendstück_Unten =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkurve_Oben_Links);

                  when GlobaleDatentypen.Straßenendstück_Oben =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkurve_Unten_Links);
                     
                  when GlobaleDatentypen.Straße_Einzeln =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenendstück_Rechts);
                     
                  when others =>
                     null;
               end case;
               Wegewert := Wegewert + 100;
               
            elsif
              YÄnderungSchleifenwert = -1
              and
                XÄnderungSchleifenwert = 0
            then
               case
                 LeseKarten.VerbesserungWeg (PositionExtern => KartenWert)
               is
                  when GlobaleDatentypen.Leer =>
                     Wegewert := Wegewert - 10;
                     
                  when GlobaleDatentypen.Straße_Waagrecht =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Unten);
                     
                  when GlobaleDatentypen.Straßenkurve_Oben_Rechts =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Rechts);

                  when GlobaleDatentypen.Straßenkurve_Oben_Links =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Links);

                  when GlobaleDatentypen.Straßenkreuzung_Drei_Oben =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Vier);

                  when GlobaleDatentypen.Straßenendstück_Links =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkurve_Unten_Rechts);

                  when GlobaleDatentypen.Straßenendstück_Rechts =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkurve_Unten_Links);

                  when GlobaleDatentypen.Straßenendstück_Unten =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straße_Senkrecht);
                     
                  when GlobaleDatentypen.Straße_Einzeln =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenendstück_Oben);
                     
                  when others =>
                     null;
               end case;
               Wegewert := Wegewert + 10;
               
            elsif
              YÄnderungSchleifenwert = 1
              and
                XÄnderungSchleifenwert = 0
            then
               case
                 LeseKarten.VerbesserungWeg (PositionExtern => KartenWert)
               is
                  when GlobaleDatentypen.Leer =>
                     Wegewert := Wegewert - 1;
                     
                  when GlobaleDatentypen.Straße_Waagrecht =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Oben);
                     
                  when GlobaleDatentypen.Straßenkurve_Unten_Rechts =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Rechts);

                  when GlobaleDatentypen.Straßenkurve_Unten_Links =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Links);

                  when GlobaleDatentypen.Straßenkreuzung_Drei_Unten =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkreuzung_Vier);

                  when GlobaleDatentypen.Straßenendstück_Links =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkurve_Oben_Rechts);

                  when GlobaleDatentypen.Straßenendstück_Rechts =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenkurve_Oben_Links);

                  when GlobaleDatentypen.Straßenendstück_Oben =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straße_Senkrecht);
                     
                  when GlobaleDatentypen.Straße_Einzeln =>
                     SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                                     WegExtern      => GlobaleDatentypen.Straßenendstück_Unten);
                     
                  when others =>
                     null;
               end case;
               Wegewert := Wegewert + 1;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      case
        Wegewert
      is
         when 11_111 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Vier);

         when 11_110 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Oben);

         when 11_101 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Unten);
            
         when 11_100 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straße_Waagrecht);
            
         when 11_011 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Links);

         when 11_010 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Oben_Links);

         when 11_001 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Unten_Links);
            
         when 11_000 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenendstück_Rechts);

         when 10_111 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Rechts);

         when 10_110 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Oben_Rechts);

         when 10_101 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Unten_Rechts);

         when 10_100 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenendstück_Links);

         when 10_011 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straße_Senkrecht);

         when 10_010 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenendstück_Unten);

         when 10_001 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenendstück_Oben);
         
         when others =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straße_Einzeln);
      end case;
      
   end StraßeBerechnung;

end Verbesserungen;
