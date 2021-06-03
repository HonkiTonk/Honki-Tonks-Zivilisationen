pragma SPARK_Mode (On);

with KIDatentypen;

with EinheitenDatenbank, Anzeige, FelderwerteFestlegen, KartenPruefungen, KarteneigenschaftVereinfachung;

package body Verbesserungen is

   -- 0 = Sie hat nichts zu tun, > 0 = Sie hat eine festgelegte Aufgabe (z. B. Straße bauen)
   procedure Verbesserung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in GlobaleDatentypen.Befehle_Enum)
   is begin

      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung = GlobaleDatentypen.Keine
      then
         VerbesserungFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 BefehlExtern             => BefehlExtern);
         
      elsif
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2
      then
         VerbesserungFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 BefehlExtern             => BefehlExtern);
         
      else
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 7);
         case
           Wahl
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
      BefehlExtern : in GlobaleDatentypen.Befehle_Enum)
   is begin

      -- Befehle_Enum (Keine, Straße_Bauen, Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen, Heilen, Verschanzen, Runde_Aussetzen, Einheit_Auflösen, Plündern);
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Keine;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger := GlobaleDatentypen.Keine;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 0;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeitNachfolger := 0;

      Grund := KarteneigenschaftVereinfachung.KartenGrundVereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        BefehlExtern = GlobaleDatentypen.Straße_Bauen
      then
         VerbesserungStraße (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                              GrundExtern              => Grund);
         
      elsif
        BefehlExtern = GlobaleDatentypen.Mine_Bauen
      then
         VerbesserungMine (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                           GrundExtern              => Grund);
         
      elsif
        BefehlExtern = GlobaleDatentypen.Farm_Bauen
      then
         VerbesserungFarm (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                           GrundExtern              => Grund);
         
      elsif
        BefehlExtern = GlobaleDatentypen.Festung_Bauen
      then
         VerbesserungFestung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                              GrundExtern              => Grund);
         
      elsif
        BefehlExtern = GlobaleDatentypen.Wald_Aufforsten
      then
         VerbesserungWald (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                           GrundExtern              => Grund);
         
      elsif
        BefehlExtern = GlobaleDatentypen.Roden_Trockenlegen
      then
         VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                            GrundExtern              => Grund);
         
      elsif
        BefehlExtern = GlobaleDatentypen.Heilen
      then
         VerbesserungHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        BefehlExtern = GlobaleDatentypen.Verschanzen
      then
         VerbesserungVerschanzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        BefehlExtern = GlobaleDatentypen.Runde_Aussetzen
      then
         VerbesserungAussetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        BefehlExtern = GlobaleDatentypen.Einheit_Auflösen
      then
         VerbesserungAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        BefehlExtern = GlobaleDatentypen.Plündern
      then
         VerbesserungPlündern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         null;
      end if;
      
   end VerbesserungFestgelegt;



   procedure VerbesserungStraße
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.KartenGrund)
   is begin
      
      if
        EinheitRasseNummerExtern.Rasse in 1 .. 1
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (2) = False
      then
         VerbesserungFehler (WelcherFehlerExtern => 18);
         return;
      
      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungStraße in 5 .. 19
      then
         VerbesserungFehler (WelcherFehlerExtern => 4);
         return;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when 1 | 3 .. 6 | 8 | 10 .. 28 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Straße_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;

         when 7 | 9 | 32 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Straße_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 6;
               
         when others =>
            VerbesserungFehler (WelcherFehlerExtern => 1);
      end case;
      
   end VerbesserungStraße;
   
   
   
   procedure VerbesserungMine
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.KartenGrund)
   is begin
      
      if
        EinheitRasseNummerExtern.Rasse in 1 .. 1
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (3) = False
      then
         VerbesserungFehler (WelcherFehlerExtern => 18);
         return;
      
      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 21
      then
         VerbesserungFehler (WelcherFehlerExtern => 4);
         return;

      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 20
        or
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 22
      then
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8);
         case
           Wahl
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
         when 1 | 3 .. 6 | 10 .. 28 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Mine_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;

         when 7 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Mine_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 5;

         when 8 | 9 | 32 =>
            VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               GrundExtern              => GrundExtern);
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger := GlobaleDatentypen.Mine_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeitNachfolger := 3;
               
         when others =>
            VerbesserungFehler (WelcherFehlerExtern => 1);
      end case;
      
   end VerbesserungMine;

   
   
   procedure VerbesserungFarm
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.KartenGrund)
   is begin

      if
        EinheitRasseNummerExtern.Rasse in 1 .. 1
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (1) = False
      then
         VerbesserungFehler (WelcherFehlerExtern => 18);
         return;
      
      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 20
      then
         VerbesserungFehler (WelcherFehlerExtern => 4);
         return;

      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund = 1
      then
         VerbesserungFehler (WelcherFehlerExtern => 1);
         return;

      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 21
        or
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 22
      then
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8);
         case
           Wahl
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
         when 3 .. 6 | 10 .. 28 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Farm_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;

         when 7 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Farm_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 5;

         when 8 .. 9 | 32 =>
            VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               GrundExtern              => GrundExtern);
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger := GlobaleDatentypen.Farm_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeitNachfolger := 3;
               
         when others =>
            VerbesserungFehler (WelcherFehlerExtern => 1);
      end case;
      
   end VerbesserungFarm;
   
   
   
   procedure VerbesserungFestung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.KartenGrund)
   is begin
      
      if
        EinheitRasseNummerExtern.Rasse in 1 .. 1
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (5) = False
      then
         VerbesserungFehler (WelcherFehlerExtern => 18);
         return;
      
      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 22
      then
         VerbesserungFehler (WelcherFehlerExtern => 4);
         return;

      elsif
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 20
        or
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 21
      then
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8);
         case
           Wahl
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
         when 1 | 3 .. 6 | 8 .. 28 | 32 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Festung_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;

         when 7 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Festung_Bauen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 5;
               
         when others =>
            VerbesserungFehler (WelcherFehlerExtern => 1);
      end case;
      
   end VerbesserungFestung;
   
   
   
   procedure VerbesserungWald
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.KartenGrund)
   is begin
      
      if
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 20
        or
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 21
      then
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8);
         case
           Wahl
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
         when 3 | 6 | 10 .. 28 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Wald_Aufforsten;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;

         when 9 | 32 =>
            VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               GrundExtern              => GrundExtern);
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger := GlobaleDatentypen.Wald_Aufforsten;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeitNachfolger := 3;
               
         when others =>
            VerbesserungFehler (WelcherFehlerExtern => 1);
      end case;
      
   end VerbesserungWald;
   
   
   
   procedure VerbesserungRoden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.KartenGrund)
   is begin
      
      if
        EinheitRasseNummerExtern.Rasse in 1 .. 1
        and
          GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Erforscht (5) = False
      then
         VerbesserungFehler (WelcherFehlerExtern => 18);
         return;
      
      else
         null;
      end if;

      case
        GrundExtern
      is
         when 8 | 9 | 32 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Roden_Trockenlegen;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;
              
         when others =>
            VerbesserungFehler (WelcherFehlerExtern => 2);
      end case;
      
   end VerbesserungRoden;
   
   
   
   procedure VerbesserungHeilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleLebenspunkte
        = EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleLebenspunkte
      then
         VerbesserungFehler (WelcherFehlerExtern => 5);
               
      else
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Heilen;
      end if;
      
   end VerbesserungHeilen;
   
   
   
   procedure VerbesserungVerschanzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Verschanzen;
      
   end VerbesserungVerschanzen;
   
   
   
   procedure VerbesserungAussetzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte := 0.0;
      return;
      
   end VerbesserungAussetzen;
   
   
   
   procedure VerbesserungAuflösen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 9);
      case
        Wahl
      is
         when True =>
            EinheitenDatenbank.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                     
         when False =>
            null;
      end case;
      
   end VerbesserungAuflösen;
   
   
   
   procedure VerbesserungPlündern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 12);
      case
        Wahl
      is
         when True =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet := 0;
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungStraße := 0;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte := 0.0;
                     
         when False =>
            null;
      end case;
      
   end VerbesserungPlündern;
   


   procedure VerbesserungFehler
     (WelcherFehlerExtern : in Positive)
   is begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                            TextZeileExtern => WelcherFehlerExtern);
      
   end VerbesserungFehler;
   


   procedure VerbesserungFertiggestellt
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen loop
         EinheitenSchleife:
         for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
            if
              GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = 0
            then
               exit EinheitenSchleife;
               
            elsif
              GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID = 0
            then
               null;

            else
               VerbesserungFertiggestelltPrüfen (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert));
            end if;
         
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end VerbesserungFertiggestellt;



   procedure VerbesserungFertiggestelltPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung
      is
         when GlobaleDatentypen.Keine | GlobaleDatentypen.Heilen | GlobaleDatentypen.Verschanzen =>
            return;
               
         when others =>
            null;
      end case;

      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit
        := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit - 1;
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit = 0
      then
         VerbesserungAngelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         case
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger
         is
            when GlobaleDatentypen.Keine =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Keine;
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 0;

            when others =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger;
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeitNachfolger;
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger := GlobaleDatentypen.Keine;
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeitNachfolger := 0;
         end case;
                        
      else
         null;
      end if;
      
   end VerbesserungFertiggestelltPrüfen;



   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung
      is
         when GlobaleDatentypen.Straße_Bauen =>
            StraßeBerechnung (KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition);
              
         when GlobaleDatentypen.Mine_Bauen =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet := 21;
            
         when GlobaleDatentypen.Farm_Bauen =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet := 20;
            
         when GlobaleDatentypen.Festung_Bauen =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet := 22;
              
         when GlobaleDatentypen.Wald_Aufforsten =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund := 8;
            if
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet in 20 .. 21
            then
               Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet := 0;
                  
            else
               null;
            end if;
              
         when GlobaleDatentypen.Roden_Trockenlegen =>
            if
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Hügel = True
            then
               Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund := 6;
                  
            else
               Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund := 3;
            end if;
            
         when others =>
            null;
      end case;

      FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => False,
                                                 KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition);
      
   end VerbesserungAngelegt;



   procedure StraßeBerechnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin

      Straßenwert := 10_000;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => KoordinatenExtern,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);

            case
              KartenWert.YAchse
            is
               when 0 =>
                  exit XAchseSchleife;

               when others =>
                  null;
            end case;

            if
              XÄnderungSchleifenwert = -1
              and
                YÄnderungSchleifenwert = 0
            then
               case
                 Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße
               is
                  when 0 =>
                     Straßenwert := Straßenwert - 1_000;

                  when 7 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 14;
                     
                  when 9 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 13;

                  when 11 =>                     
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 12;

                  when 15 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 5;

                  when 17 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 6;

                  when 18 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 10;

                  when 19 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 8;
                     
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
                  when 0 =>
                     Straßenwert := Straßenwert - 100;

                  when 7 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 15;
                     
                  when 8 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 13;

                  when 10 =>                     
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 12;

                  when 14 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 5;

                  when 16 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 6;

                  when 18 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 11;

                  when 19 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 9;
                     
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
                  when 0 =>
                     Straßenwert := Straßenwert - 10;
                     
                  when 6 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 13;
                     
                  when 10 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 14;

                  when 11 =>                     
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 15;

                  when 12 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 5;

                  when 16 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 8;

                  when 17 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 9;

                  when 18 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 7;
                     
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
                  when 0 =>
                     Straßenwert := Straßenwert - 1;
                     
                  when 6 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 12;
                     
                  when 8 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 14;

                  when 9 =>                     
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 15;

                  when 13 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 5;

                  when 16 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 10;

                  when 17 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 11;

                  when 19 =>
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße := 7;
                     
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
         when 11_000 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 17;

         when 10_100 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 16;

         when 10_010 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 18;

         when 10_001 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 19;

         when 11_010 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 11;

         when 11_001 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 9;

         when 11_110 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 12;

         when 11_101 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 13;

         when 11_111 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 5;

         when 10_110 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 10;

         when 10_101 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 8;

         when 10_111 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 14;

         when 10_011 =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 7;
         
         when others =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungStraße := 6;
      end case;
      
   end StraßeBerechnung;

end Verbesserungen;
