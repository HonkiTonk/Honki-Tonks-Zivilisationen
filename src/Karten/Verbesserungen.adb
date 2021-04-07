pragma SPARK_Mode (On);

with EinheitenDatenbank, Anzeige, FelderwerteFestlegen, KartenPruefungen;

package body Verbesserungen is

   -- 0 = Sie hat nichts zu tun, > 0 = Sie hat eine festgelegte Aufgabe (z. B. Straße bauen)
   procedure Verbesserung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in Befehle_Enum)
   is begin

      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung = 0
      then
         VerbesserungeFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                  BefehlExtern             => BefehlExtern);
         
      else
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 7);
         case
           Wahl
         is
            when True =>
               VerbesserungeFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        BefehlExtern             => BefehlExtern);
                     
            when False =>
               null;
         end case;
      end if;
      
   end Verbesserung;
   


   -- 0 = Sie hat nichts zu tun, > 0 = Sie hat eine festgelegte Aufgabe (z. B. Straße bauen)
   procedure VerbesserungeFestgelegt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in Befehle_Enum)
   is begin

      if
        BefehlExtern = Straße_Bauen
        and
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungStraße >= 5
          and
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungStraße <= 19
      then
         VerbesserungFehler (WelcherFehlerExtern => 4);
         return;

      elsif
        BefehlExtern = Mine_Bauen
        and
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 21
      then
         VerbesserungFehler (WelcherFehlerExtern => 4);
         return;

      elsif
        BefehlExtern = Mine_Bauen
        and
          (Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 20
           or
             Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 22)
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
      
      elsif
        BefehlExtern = Farm_Bauen
        and
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 20
      then
         VerbesserungFehler (WelcherFehlerExtern => 4);
         return;

      elsif
        BefehlExtern = Farm_Bauen
        and
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund = 1
      then
         VerbesserungFehler (WelcherFehlerExtern => 1);
         return;

      elsif
        BefehlExtern = Farm_Bauen
        and
          (Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 21
           or
             Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 22)
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
      
      elsif
        BefehlExtern = Festung_Bauen
        and
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 22
      then
         VerbesserungFehler (WelcherFehlerExtern => 4);
         return;

      elsif
        BefehlExtern = Festung_Bauen
        and
          (Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 20
           or
             Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 21)
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

      elsif
        BefehlExtern = Wald_Aufforsten
        and
          (Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 20
           or
             Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 21)
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
         
      elsif
        BefehlExtern = Runde_Aussetzen
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte := 0.0;
         return;
                              
      else
         null;
      end if;
                              
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := 0;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger := 0;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 0;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeitNachfolger := 0;
      
      case
        BefehlExtern
      is
         when Straße_Bauen => -- Landstraße und später Schiene
            case
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund
            is
               when 1 | 3 .. 6 | 8 | 10 .. 28 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;

               when 7 | 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 6;
               
               when others =>
                  VerbesserungFehler (WelcherFehlerExtern => 1);
            end case;
                              
         when Mine_Bauen => -- Tiefengrabung
            case
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund
            is
               when 1 | 3 .. 6 | 10 .. 28 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;

               when 7 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 5;

               when 8 | 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := 6;
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeitNachfolger := 3;
               
               when others =>
                  VerbesserungFehler (WelcherFehlerExtern => 1);
            end case;
            
         when Farm_Bauen => -- Farm bauen
            case
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund
            is
               when 3 .. 6 | 10 .. 28 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;

               when 7 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 5;

               when 8 .. 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := 6;
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeitNachfolger := 3;
               
               when others =>
                  VerbesserungFehler (WelcherFehlerExtern => 1);
            end case;
            
         when Festung_Bauen => -- Festung bauen
            case
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund
            is
               when 1 | 3 .. 6 | 8 .. 28 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;

               when 7 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 5;
               
               when others =>
                  VerbesserungFehler (WelcherFehlerExtern => 1);
            end case;
            
         when Wald_Aufforsten => -- Wald aufforsten
            case
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund
            is
               when 3 | 6 | 10 .. 28 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;

               when 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := 6;
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeitNachfolger := 3;
               
               when others =>
                  VerbesserungFehler (WelcherFehlerExtern => 1);
            end case;

         when Roden_Trockenlegen => -- Roden-Trockenlegen
            case
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund
            is
               when 8 | 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := Befehle_Enum'Pos (BefehlExtern);
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 3;
              
               when others =>
                  VerbesserungFehler (WelcherFehlerExtern => 2);
            end case;
            
         when Heilen => -- Heilen
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleLebenspunkte
              = EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleLebenspunkte
            then
               VerbesserungFehler (WelcherFehlerExtern => 5);
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := Befehle_Enum'Pos (BefehlExtern);
            end if;

         when Verschanzen => -- Verschanzen
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := Befehle_Enum'Pos (BefehlExtern);
            
         when Einheit_Auflösen => -- Einheit auflösen
            Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 9);
            case
              Wahl
            is
               when True =>
                  EinheitenDatenbank.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                     
               when False =>
                  null;
            end case;

         when Plündern => -- Plündern
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
                     
         when others =>
            null;
      end case;
            
   end VerbesserungeFestgelegt;
   


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
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when 0 =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
                  case
                    GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID
                  is
                     when 0 =>
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
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung
      is
         when 0 | 7 .. 8 =>
            null;
               
         when others =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit
              := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit - 1;
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit = 0
            then
               VerbesserungAngelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

               case
                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger
               is
                  when 0 =>
                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := 0;
                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit := 0;

                  when others =>
                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung
                       := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger;
                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeit
                       := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeitNachfolger;
                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger := 0;
                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungszeitNachfolger := 0;
               end case;
                        
            else
               null;
            end if;
      end case;
      
   end VerbesserungFertiggestelltPrüfen;



   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung
      is -- Landstraße/Tiefengrabung/Farm/Festung/Wald aufforsten/Roden-Trockenlegen
         when 1 =>
            StraßeBerechnung (KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition);
              
         when 2 =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet := 21;
            
         when 3 =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet := 20;
            
         when 4 =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet := 22;
              
         when 5 =>
            Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund := 8;
            case
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet
            is
               when 20 .. 21 =>
                  Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                    GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                    GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet := 0;
                  
               when others =>
                  null;
            end case;
              
         when 6 =>
            case
              Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Hügel
            is
               when True =>
                  Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                    GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                    GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund := 6;
                  
               when False =>
                  Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                    GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                    GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund := 3;
            end case;
            
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
              KartenWert.Erfolgreich
            is
               when False =>
                  exit XAchseSchleife;

               when True =>
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
