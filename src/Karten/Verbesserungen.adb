pragma SPARK_Mode (On);

with GlobaleTexte, GlobaleKonstanten;

with KIDatentypen;

with EinheitenDatenbank;
  
with Anzeige, FelderwerteFestlegen, KartePositionPruefen, EinheitenAllgemein, FeldTesten;

package body Verbesserungen is

   procedure Verbesserung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in GlobaleDatentypen.Tastenbelegung_Befehle_Enum)
   is begin

      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung = GlobaleDatentypen.Nicht_Vorhanden
      then
         VerbesserungFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 BefehlExtern             => BefehlExtern);
         
      elsif
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         VerbesserungFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 BefehlExtern             => BefehlExtern);
         
      else
         case
           EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 7)
         is
            when True =>
               VerbesserungFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       BefehlExtern             => BefehlExtern);
                     
            when False =>
               null;
         end case;
      end if;
      
   end Verbesserung;
   


   procedure VerbesserungFestgelegt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in GlobaleDatentypen.Tastenbelegung_Befehle_Enum)
   is begin

      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Nicht_Vorhanden;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger := GlobaleDatentypen.Nicht_Vorhanden;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 0;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := 0;

      Grund := Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).Grund;
      
      case
        BefehlExtern
      is
         when GlobaleDatentypen.Straße_Bauen =>
            VerbesserungStraße (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 GrundExtern              => Grund);
         
         when GlobaleDatentypen.Mine_Bauen =>
            VerbesserungMine (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                              GrundExtern              => Grund);
         
         when GlobaleDatentypen.Farm_Bauen =>
            VerbesserungFarm (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                              GrundExtern              => Grund);
         
         when GlobaleDatentypen.Festung_Bauen =>
            VerbesserungFestung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 GrundExtern              => Grund);
         
         when GlobaleDatentypen.Wald_Aufforsten =>
            VerbesserungWald (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                              GrundExtern              => Grund);
         
         when GlobaleDatentypen.Roden_Trockenlegen =>
            VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               GrundExtern              => Grund);
         
         when GlobaleDatentypen.Heilen =>
            VerbesserungHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when GlobaleDatentypen.Verschanzen =>
            VerbesserungVerschanzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when GlobaleDatentypen.Runde_Aussetzen =>
            VerbesserungAussetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when GlobaleDatentypen.Einheit_Auflösen =>
            VerbesserungAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when GlobaleDatentypen.Plündern =>
            if
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungStraße /= GlobaleDatentypen.Leer
              or
                Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet /= GlobaleDatentypen.Leer
            then
               VerbesserungPlündern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
            else
               null;
            end if;
         
         when GlobaleDatentypen.Einheit_Verbessern =>
            VerbesserungEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end VerbesserungFestgelegt;



   procedure VerbesserungStraße
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
   is begin
      
      if
        EinheitRasseNummerExtern.Rasse = GlobaleDatentypen.Moru_Phisihl
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (2) = False
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
      then
         VerbesserungFehler (WelcherFehlerExtern => 18);
         return;
         
      elsif
        EinheitRasseNummerExtern.Rasse = GlobaleDatentypen.Moru_Phisihl
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (2) = False
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         return;
      
      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungStraße
      in
        GlobaleDatentypen.Karten_Verbesserung_Straße_Enum'Range
      then
         VerbesserungFehler (WelcherFehlerExtern => 4);
         return;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Flachland | GlobaleDatentypen.Tundra | GlobaleDatentypen.Wüste | GlobaleDatentypen.Hügel | GlobaleDatentypen.Wald
            | GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range | GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Straße_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 3;

         when GlobaleDatentypen.Gebirge | GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Straße_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 6;
               
         when others =>
            if
              GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
            then
               VerbesserungFehler (WelcherFehlerExtern => 1);
               
            else
               null;
            end if;
      end case;
      
   end VerbesserungStraße;
   
   
   
   procedure VerbesserungMine
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
   is begin
      
      if
        EinheitRasseNummerExtern.Rasse = GlobaleDatentypen.Moru_Phisihl
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (3) = False
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
      then
         VerbesserungFehler (WelcherFehlerExtern => 18);
         return;
         
      elsif
        EinheitRasseNummerExtern.Rasse = GlobaleDatentypen.Moru_Phisihl
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (3) = False
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         return;
      
      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet = GlobaleDatentypen.Mine
      then
         VerbesserungFehler (WelcherFehlerExtern => 4);
         return;

      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet = GlobaleDatentypen.Farm
        or
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet = GlobaleDatentypen.Festung
      then
         case
           EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8)
         is
            when True =>
               null;
                     
            when False =>
               return;
         end case;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Flachland | GlobaleDatentypen.Tundra | GlobaleDatentypen.Wüste | GlobaleDatentypen.Hügel
            | GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range | GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Mine_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 3;

         when GlobaleDatentypen.Gebirge =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Mine_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 5;

         when GlobaleDatentypen.Wald | GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               GrundExtern              => GrundExtern);
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger := GlobaleDatentypen.Mine_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := 3;
               
         when others =>
            if
              GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
            then
               VerbesserungFehler (WelcherFehlerExtern => 1);
               
            else
               null;
            end if;
      end case;
      
   end VerbesserungMine;

   
   
   procedure VerbesserungFarm
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
   is begin

      if
        EinheitRasseNummerExtern.Rasse = GlobaleDatentypen.Moru_Phisihl
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (1) = False
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
      then
         VerbesserungFehler (WelcherFehlerExtern => 18);
         return;
         
      elsif
        EinheitRasseNummerExtern.Rasse = GlobaleDatentypen.Moru_Phisihl
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (1) = False
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         return;
      
      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet = GlobaleDatentypen.Farm
      then
         VerbesserungFehler (WelcherFehlerExtern => 4);
         return;

      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).Grund = GlobaleDatentypen.Eis
      then
         VerbesserungFehler (WelcherFehlerExtern => 1);
         return;

      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet = GlobaleDatentypen.Mine
        or
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet = GlobaleDatentypen.Festung
      then
         case
           EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8)
         is
            when True =>
               null;
                     
            when False =>
               return;
         end case;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when GlobaleDatentypen.Flachland | GlobaleDatentypen.Tundra | GlobaleDatentypen.Wüste | GlobaleDatentypen.Hügel
            | GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range | GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Farm_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 3;

         when GlobaleDatentypen.Gebirge =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Farm_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 5;

         when GlobaleDatentypen.Wald | GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               GrundExtern              => GrundExtern);
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger := GlobaleDatentypen.Farm_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := 3;
               
         when others =>
            if
              GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
            then
               VerbesserungFehler (WelcherFehlerExtern => 1);
               
            else
               null;
            end if;
      end case;
      
   end VerbesserungFarm;
   
   
   
   procedure VerbesserungFestung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
   is begin
      
      if
        EinheitRasseNummerExtern.Rasse = GlobaleDatentypen.Moru_Phisihl
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (5) = False
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
      then
         VerbesserungFehler (WelcherFehlerExtern => 18);
         return;
         
      elsif
        EinheitRasseNummerExtern.Rasse = GlobaleDatentypen.Moru_Phisihl
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (5) = False
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         return;
      
      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet = GlobaleDatentypen.Festung
      then
         VerbesserungFehler (WelcherFehlerExtern => 4);
         return;

      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet = GlobaleDatentypen.Farm
        or
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet = GlobaleDatentypen.Mine
      then
         case
           EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8)
         is
            when True =>
               null;
                     
            when False =>
               return;
         end case;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Flachland | GlobaleDatentypen.Tundra | GlobaleDatentypen.Wüste | GlobaleDatentypen.Hügel | GlobaleDatentypen.Wald | GlobaleDatentypen.Dschungel
            | GlobaleDatentypen.Karten_Grund_Fluss_Enum'Range | GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Festung_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 3;

         when GlobaleDatentypen.Gebirge =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Festung_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 5;
               
         when others =>
            if
              GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
            then
               VerbesserungFehler (WelcherFehlerExtern => 1);
               
            else
               null;
            end if;
      end case;
      
   end VerbesserungFestung;
   
   
   
   procedure VerbesserungWald
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
   is begin
      
      if
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet = GlobaleDatentypen.Farm
        or
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet = GlobaleDatentypen.Mine
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
            return;
            
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
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Wald_Aufforsten;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 3;

         when GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               GrundExtern              => GrundExtern);
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger := GlobaleDatentypen.Wald_Aufforsten;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := 3;
               
         when others =>
            if
              GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
            then
               VerbesserungFehler (WelcherFehlerExtern => 1);
               
            else
               null;
            end if;
      end case;
      
   end VerbesserungWald;
   
   
   
   procedure VerbesserungRoden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
   is begin
      
      if
        EinheitRasseNummerExtern.Rasse = GlobaleDatentypen.Moru_Phisihl
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (5) = False
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
      then
         VerbesserungFehler (WelcherFehlerExtern => 18);
         return;
         
      elsif
        EinheitRasseNummerExtern.Rasse = GlobaleDatentypen.Moru_Phisihl
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (5) = False
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         return;
      
      else
         null;
      end if;

      case
        GrundExtern
      is
         when GlobaleDatentypen.Wald | GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Roden_Trockenlegen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 3;
              
         when others =>
            if
              GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
            then
               VerbesserungFehler (WelcherFehlerExtern => 2);
               
            else
               null;
            end if;
      end case;
      
   end VerbesserungRoden;
   
   
   
   procedure VerbesserungHeilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
        = EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleLebenspunkte
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
      then
         VerbesserungFehler (WelcherFehlerExtern => 5);
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
        = EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleLebenspunkte
      then
         null;
         
      else
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Heilen;
      end if;
      
   end VerbesserungHeilen;
   
   
   
   procedure VerbesserungVerschanzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Verschanzen;
      
   end VerbesserungVerschanzen;
   
   
   
   procedure VerbesserungAussetzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := GlobaleKonstanten.LeerEinheit.Bewegungspunkte;
      return;
      
   end VerbesserungAussetzen;
   
   
   
   procedure VerbesserungAuflösen
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
      
   end VerbesserungAuflösen;
   
   
   
   procedure VerbesserungPlündern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch
        and then
          EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 12) = True
      then
         Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet := GlobaleDatentypen.Leer;
         Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungStraße := GlobaleDatentypen.Leer;
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := GlobaleKonstanten.LeerEinheit.Bewegungspunkte;
         
      elsif
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet := GlobaleDatentypen.Leer;
         Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungStraße := GlobaleDatentypen.Leer;
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := GlobaleKonstanten.LeerEinheit.Bewegungspunkte;
                     
      else
         null;
      end if;
      
   end VerbesserungPlündern;
   
   
   
   procedure VerbesserungEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        (EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).WirdVerbessertZu /= 0
         and
           FeldTesten.BelegterGrundTesten (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                           KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position) = True)
        and then
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht
        (EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
         EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).WirdVerbessertZu).Anforderungen)
        = True
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := GlobaleKonstanten.LeerEinheit.Bewegungspunkte;
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID
           := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).WirdVerbessertZu;
         
      else
         null;
      end if;
      
   end VerbesserungEinheit;
   


   procedure VerbesserungFehler
     (WelcherFehlerExtern : in Positive)
   is begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                            TextZeileExtern => WelcherFehlerExtern);
      
   end VerbesserungFehler;
   


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
               for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebaut'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
         
                  if
                    GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID = GlobaleKonstanten.LeerEinheit.ID
                  then
                     null;

                  else
                     VerbesserungFertiggestelltPrüfen (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert));
                  end if;
         
               end loop EinheitenSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end VerbesserungFertiggestellt;



   procedure VerbesserungFertiggestelltPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung
      is
         when GlobaleDatentypen.Nicht_Vorhanden | GlobaleDatentypen.Heilen | GlobaleDatentypen.Verschanzen =>
            return;
               
         when others =>
            null;
      end case;

      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit
        := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit - 1;
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit = GlobaleKonstanten.LeerEinheit.Beschäftigungszeit
      then
         VerbesserungAngelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         case
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger
         is
            when GlobaleDatentypen.Nicht_Vorhanden =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Nicht_Vorhanden;
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := GlobaleKonstanten.LeerEinheit.Beschäftigungszeit;

            when others =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger;
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger;
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger := GlobaleDatentypen.Nicht_Vorhanden;
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := GlobaleKonstanten.LeerEinheit.BeschäftigungszeitNachfolger;
         end case;
                        
      else
         null;
      end if;
      
   end VerbesserungFertiggestelltPrüfen;



   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung
      is
         when GlobaleDatentypen.Straße_Bauen =>
            StraßeBerechnung (KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position);
              
         when GlobaleDatentypen.Mine_Bauen =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet := GlobaleDatentypen.Mine;
            
         when GlobaleDatentypen.Farm_Bauen =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet := GlobaleDatentypen.Farm;
            
         when GlobaleDatentypen.Festung_Bauen =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet := GlobaleDatentypen.Festung;
              
         when GlobaleDatentypen.Wald_Aufforsten =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).Grund := GlobaleDatentypen.Wald;
            if
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet
            in
              GlobaleDatentypen.Karten_Verbesserung_Gebilde_Friedlich_Enum'Range
            then
               Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).VerbesserungGebiet := GlobaleDatentypen.Leer;
                  
            else
               null;
            end if;
              
         when GlobaleDatentypen.Roden_Trockenlegen =>
            if
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).Hügel = True
            then
               Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).Grund := GlobaleDatentypen.Hügel;
                  
            else
               Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).Grund := GlobaleDatentypen.Flachland;
            end if;
            
         when others =>
            null;
      end case;

      FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => False,
                                                 KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position);
      
   end VerbesserungAngelegt;



   procedure StraßeBerechnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin

      Straßenwert := 10_000;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => KoordinatenExtern,
                                                                        ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
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
                 Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße
               is
                  when GlobaleDatentypen.Leer =>
                     Straßenwert := Straßenwert - 1_000;

                  when GlobaleDatentypen.Straße_Senkrecht =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Rechts;
                     
                  when GlobaleDatentypen.Straßenkurve_Unten_Links =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Unten;

                  when GlobaleDatentypen.Straßenkurve_Oben_Links =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Oben;

                  when GlobaleDatentypen.Straßenkreuzung_Drei_Links =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Vier;

                  when GlobaleDatentypen.Straßenendstück_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straße_Waagrecht;

                  when GlobaleDatentypen.Straßenendstück_Unten =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkurve_Oben_Rechts;

                  when GlobaleDatentypen.Straßenendstück_Oben =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkurve_Unten_Rechts;
                     
                  when GlobaleDatentypen.Straße_Einzeln =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenendstück_Links;
                     
                  when others =>
                     null;
               end case;
               Straßenwert := Straßenwert + 1_000;
               
            elsif
              XÄnderungSchleifenwert = 1
              and
                YÄnderungSchleifenwert = 0
            then
               case
                 Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße
               is
                  when GlobaleDatentypen.Leer =>
                     Straßenwert := Straßenwert - 100;

                  when GlobaleDatentypen.Straße_Senkrecht =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Links;
                     
                  when GlobaleDatentypen.Straßenkurve_Unten_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Unten;

                  when GlobaleDatentypen.Straßenkurve_Oben_Rechts =>                     
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Oben;

                  when GlobaleDatentypen.Straßenkreuzung_Drei_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Vier;

                  when GlobaleDatentypen.Straßenendstück_Links =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straße_Waagrecht;

                  when GlobaleDatentypen.Straßenendstück_Unten =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkurve_Oben_Links;

                  when GlobaleDatentypen.Straßenendstück_Oben =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkurve_Unten_Links;
                     
                  when GlobaleDatentypen.Straße_Einzeln =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenendstück_Rechts;
                     
                  when others =>
                     null;
               end case;
               Straßenwert := Straßenwert + 100;
               
            elsif
              YÄnderungSchleifenwert = -1
              and
                XÄnderungSchleifenwert = 0
            then
               case
                 Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße
               is
                  when GlobaleDatentypen.Leer =>
                     Straßenwert := Straßenwert - 10;
                     
                  when GlobaleDatentypen.Straße_Waagrecht =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Unten;
                     
                  when GlobaleDatentypen.Straßenkurve_Oben_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Rechts;

                  when GlobaleDatentypen.Straßenkurve_Oben_Links =>                     
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Links;

                  when GlobaleDatentypen.Straßenkreuzung_Drei_Oben =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Vier;

                  when GlobaleDatentypen.Straßenendstück_Links =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkurve_Unten_Rechts;

                  when GlobaleDatentypen.Straßenendstück_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkurve_Unten_Links;

                  when GlobaleDatentypen.Straßenendstück_Unten =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straße_Senkrecht;
                     
                  when GlobaleDatentypen.Straße_Einzeln =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenendstück_Oben;
                     
                  when others =>
                     null;
               end case;
               Straßenwert := Straßenwert + 10;
               
            elsif
              YÄnderungSchleifenwert = 1
              and
                XÄnderungSchleifenwert = 0
            then
               case
                 Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße
               is
                  when GlobaleDatentypen.Leer =>
                     Straßenwert := Straßenwert - 1;
                     
                  when GlobaleDatentypen.Straße_Waagrecht =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Oben;
                     
                  when GlobaleDatentypen.Straßenkurve_Unten_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Rechts;

                  when GlobaleDatentypen.Straßenkurve_Unten_Links =>                     
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Links;

                  when GlobaleDatentypen.Straßenkreuzung_Drei_Unten =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Vier;

                  when GlobaleDatentypen.Straßenendstück_Links =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkurve_Oben_Rechts;

                  when GlobaleDatentypen.Straßenendstück_Rechts =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkurve_Oben_Links;

                  when GlobaleDatentypen.Straßenendstück_Oben =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straße_Senkrecht;
                     
                  when GlobaleDatentypen.Straße_Einzeln =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenendstück_Unten;
                     
                  when others =>
                     null;
               end case;
               Straßenwert := Straßenwert + 1;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      case
        Straßenwert
      is
         when 11_111 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Vier;

         when 11_110 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Oben;

         when 11_101 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Unten;
            
         when 11_100 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straße_Waagrecht;
            
         when 11_011 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Links;

         when 11_010 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkurve_Oben_Links;

         when 11_001 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkurve_Unten_Links;
            
         when 11_000 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenendstück_Rechts;

         when 10_111 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkreuzung_Drei_Rechts;

         when 10_110 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkurve_Oben_Rechts;

         when 10_101 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenkurve_Unten_Rechts;

         when 10_100 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenendstück_Links;

         when 10_011 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straße_Senkrecht;

         when 10_010 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenendstück_Unten;

         when 10_001 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straßenendstück_Oben;
         
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := GlobaleDatentypen.Straße_Einzeln;
      end case;
      
   end StraßeBerechnung;

end Verbesserungen;
