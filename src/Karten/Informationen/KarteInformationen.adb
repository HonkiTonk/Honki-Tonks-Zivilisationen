pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleKonstanten, GlobaleTexte;

with KartenDatenbank, VerbesserungenDatenbank, EinheitenDatenbank;

with Anzeige, Cheat, Karten, EinheitSuchen, StadtSuchen, KarteStadt, ForschungAllgemein, VerbesserungenAllgemein, KartenAllgemein, EinheitenAllgemein;

package body KarteInformationen is

   procedure KarteInformation
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin

      Verteidigungsbonus := 0;
      Nahrungsgewinnung := 0;
      Ressourcengewinnung := 0;
      Geldgewinnung := 0;
      Wissensgewinnung := 0;
      
      -- Allgemeine Informationen über die eigene Rasse, immer sichtbar
      InformationenRundenanzahl;
      InformationenGeldmenge (RasseExtern => RasseExtern);
      InformationenGeldGewinn (RasseExtern => RasseExtern);
      InformationenForschungsprojekt (RasseExtern => RasseExtern);
      InformationenForschungszeit (RasseExtern => RasseExtern);
      InformationenForschungsmenge (RasseExtern => RasseExtern);
      InformationenForschungsrate (RasseExtern => RasseExtern);
      
      case
        Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                          GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Sichtbar (RasseExtern)
      is
         when True =>
            EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
            
            if
              EinheitRasseNummer.Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
            then
               null;
                
               -- Allgemeine Einheiteninformationen, nur sichtbar wenn das Kartenfeld aufgedackt ist und sich dort eine Einheit befindet
            else
               InformationenEinheiten (RasseExtern              => RasseExtern,
                                       EinheitRasseNummerExtern => EinheitRasseNummer);
            end if;
            
            StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);

            case
              StadtRasseNummer.Platznummer
            is
               when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
                  null;
                     
                  -- Stadtinformationsaufruf
               when others =>
                  InformationenStadt (RasseExtern            => RasseExtern,
                                      StadtRasseNummerExtern => StadtRasseNummer);
            end case;
                  
            -- Allgemeine Karteninformationen, nur sichtbar wenn das Kartenfeld aufgedeckt ist
            InformationenAllgemein (RasseExtern => RasseExtern);
            
         when False =>
            null;
      end case;

      New_Line;
      
      case
        GlobaleVariablen.FeindlicheInformationenSehen
      is
         when False =>
            null;
                                 
         when True =>
            Cheat.KarteInfosFeld (RasseExtern => RasseExtern);
      end case;
      
   end KarteInformation;
   
   
   
   procedure InformationenRundenanzahl
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 33,
                                     LetzteZeileExtern      => 33,
                                     AbstandAnfangExtern    => GlobaleTexte.Keiner,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.RundenAnzahl,
                               Width => 1);
      
   end InformationenRundenanzahl;
     
     
   
   procedure InformationenGeldmenge
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 34,
                                     LetzteZeileExtern      => 34,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge,
                               Width => 1);
      
   end InformationenGeldmenge;
     
     
     
   procedure InformationenGeldGewinn
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 35,
                                     LetzteZeileExtern      => 35,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde),
                               Width => 1);
      New_Line;
      
   end InformationenGeldGewinn;
     
     
     
     
   procedure InformationenForschungsprojekt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 38,
                                     LetzteZeileExtern      => 38,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      ForschungAllgemein.Beschreibung (IDExtern    => GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt,
                                       RasseExtern => RasseExtern);
      
   end InformationenForschungsprojekt;
     
     
     
     
   procedure InformationenForschungszeit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 36,
                                     LetzteZeileExtern      => 36,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit),
                               Width => 1);
      New_Line;
      
   end InformationenForschungszeit;
     
     
     
     
   procedure InformationenForschungsmenge
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 39,
                                     LetzteZeileExtern      => 39,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge),
                               Width => 1);
      
   end InformationenForschungsmenge;
     
     
     
     
   procedure InformationenForschungsrate
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 37,
                                     LetzteZeileExtern      => 37,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate),
                               Width => 1);
      New_Line (Spacing => 2);
      
   end InformationenForschungsrate;
   
   
   
   procedure InformationenEinheiten
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert
      is
         when 0 =>
            EinheitNummer := EinheitRasseNummerExtern.Platznummer;
                        
         when others =>
            EinheitNummer := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert;
      end case;
      EinheitenAllgemein.Beschreibung (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).ID);
      New_Line;
                  
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 14,
                                     LetzteZeileExtern      => 14,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).Lebenspunkte,
                               Width => 1);
      Put (Item => " / ");
      Ada.Integer_Text_IO.Put (Item  => EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).ID).MaximaleLebenspunkte,
                               Width => 1);
            
      -- "Volle" Einheiteninformationen, nur sichtbar wenn eigene Einheit oder wenn Cheat aktiviert ist
      if
        RasseExtern = EinheitRasseNummerExtern.Rasse
        or
          GlobaleVariablen.FeindlicheInformationenSehen
      then
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 15,
                                        LetzteZeileExtern      => 15,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Keiner,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Float_Text_IO.Put (Item => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).Bewegungspunkte,
                                Fore => 1,
                                Aft  => 2,
                                Exp  => 0);
         Put (Item => " / ");
         Ada.Float_Text_IO.Put (Item => EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,
                                EinheitNummer).ID).MaximaleBewegungspunkte,
                                Fore => 1,
                                Aft  => 2,
                                Exp  => 0);

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 16,
                                        LetzteZeileExtern      => 16,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Keiner,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).Erfahrungspunkte,
                                  Width => 1);
         Put (Item => " / ");
         Ada.Integer_Text_IO.Put (Item  => EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,
                                  EinheitNummer).ID).Beförderungsgrenze,
                                  Width => 1);
         New_Line;
                              
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 17,
                                        LetzteZeileExtern      => 17,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Keiner,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         EinheitenAllgemein.Beschäftigung (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).Beschäftigung);

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 18,
                                        LetzteZeileExtern      => 18,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Keiner,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).Beschäftigungszeit,
                                  Width => 1);
         New_Line;

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 24,
                                        LetzteZeileExtern      => 24,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Keiner,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Integer_Text_IO.Put (Item  => Integer (EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).ID).Angriff),
                                  Width => 1);

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 25,
                                        LetzteZeileExtern      => 25,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Keiner,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Integer_Text_IO.Put (Item  => Integer (EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).ID).Verteidigung),
                                  Width => 1);
                     
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 26,
                                        LetzteZeileExtern      => 26,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Keiner,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).Rang,
                                  Width => 1);
         Put (Item => " / ");
         Ada.Integer_Text_IO.Put (Item  => EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).ID).MaximalerRang,
                                  Width => 1);
         New_Line;
                              
      else
         null;
      end if;
                        
      New_Line;
      case
        GlobaleVariablen.FeindlicheInformationenSehen
      is
         when False =>
            null;
            
         when True =>
            Cheat.KarteInfosEinheiten (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer));                     
      end case;
      
   end InformationenEinheiten;
   
      
   
   procedure InformationenStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
      then
         KarteStadt.Beschreibung (RasseExtern => RasseExtern);

         -- Stadtverteidigungsinformation, nur sichtbar wenn eigene Stadt oder wenn Cheat aktiviert ist
         if
           StadtRasseNummerExtern.Rasse = RasseExtern
           or
             GlobaleVariablen.FeindlicheInformationenSehen
         then                              
            Verteidigungsbonus := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungListe (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                                                                  StadtRasseNummerExtern.Platznummer).ID).Verteidigungsbonus;

         else
            null;
         end if;

         case
           GlobaleVariablen.FeindlicheInformationenSehen
         is
            when False =>
               null;
                                 
            when True =>
               Cheat.KarteStadtInfos (StadtRasseNummerExtern => StadtRasseNummerExtern);
         end case;
                     
      else
         null;
      end if;
      
   end InformationenStadt;
   
   
   
   procedure InformationenAllgemein
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                          GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Hügel = True
        and
          Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                            GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund /= GlobaleDatentypen.Hügel
      then
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Beschreibungen_Kartenfelder_Kurz,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => GlobaleDatentypen.Karten_Grund_Enum'Pos (GlobaleDatentypen.Hügel_Mit),
                                        LetzteZeileExtern      => GlobaleDatentypen.Karten_Grund_Enum'Pos (GlobaleDatentypen.Hügel_Mit),
                                        AbstandAnfangExtern    => GlobaleTexte.Keiner,
                                        AbstandMitteExtern     => GlobaleTexte.Keiner,
                                        AbstandEndeExtern      => GlobaleTexte.Keiner);
         KartenAllgemein.Beschreibung (KartenGrundExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund);

         Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Verteidigungsbonus;
         Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Nahrungsgewinnung;
         Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Ressourcengewinnung;
         Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Geldgewinnung;
         Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Wissensgewinnung;
         
      elsif
        Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                          GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Hügel = True
      then
         KartenAllgemein.Beschreibung (KartenGrundExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund);

         Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Verteidigungsbonus;
         Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Nahrungsgewinnung;
         Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Ressourcengewinnung;
         Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Geldgewinnung;
         Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Wissensgewinnung;
               
      else         
         KartenAllgemein.Beschreibung (KartenGrundExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund);

         Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Verteidigungsbonus;
         Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Nahrungsgewinnung;
         Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Ressourcengewinnung;
         Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Geldgewinnung;
         Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund).Wissensgewinnung;
      end if;
      
      if
        Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                          GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Ressource /= GlobaleDatentypen.Leer
      then
         KartenAllgemein.Beschreibung (KartenGrundExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Ressource);

         Verteidigungsbonus
           := Verteidigungsbonus + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Ressource).Verteidigungsbonus;
         Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Ressource).Nahrungsgewinnung;
         Ressourcengewinnung
           := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Ressource).Ressourcengewinnung;
         Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Ressource).Geldgewinnung;
         Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Ressource).Wissensgewinnung;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                          GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungGebiet /= GlobaleDatentypen.Leer
      then
         VerbesserungenAllgemein.Beschreibung (KartenVerbesserungExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungGebiet);

         Verteidigungsbonus
           := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                              GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                              GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungGebiet).Verteidigungsbonus;
         Nahrungsgewinnung
           := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungGebiet).Nahrungsbonus;
         Ressourcengewinnung
           := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungGebiet).Ressourcenbonus;
         Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungGebiet).Geldbonus;
         Wissensgewinnung
           := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                            GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                            GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungGebiet).Wissensbonus;
         
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                          GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungStraße /= GlobaleDatentypen.Leer
      then
         VerbesserungenAllgemein.Beschreibung (KartenVerbesserungExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungStraße);

         Verteidigungsbonus
           := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                              GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                              GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungStraße).Verteidigungsbonus;
         Nahrungsgewinnung
           := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungStraße).Nahrungsbonus;
         Ressourcengewinnung
           := Ressourcengewinnung
             + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                          GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungStraße).Ressourcenbonus;
         Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungStraße).Geldbonus;
         Wissensgewinnung
           := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                            GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                            GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungStraße).Wissensbonus;
               
      else
         null;
      end if;
      
      if
        Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                          GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Fluss /= GlobaleDatentypen.Leer
      then
         KartenAllgemein.Beschreibung (KartenGrundExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Fluss);

         Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Fluss).Verteidigungsbonus;
         Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Fluss).Nahrungsgewinnung;
         Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Fluss).Ressourcengewinnung;
         Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Fluss).Geldgewinnung;
         Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Fluss).Wissensgewinnung;
         
      else
         null;
      end if;
            
      New_Line;
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 19,
                                     LetzteZeileExtern      => 19,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Verteidigungsbonus),
                               Width => 1);
            
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 20,
                                     LetzteZeileExtern      => 20,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Nahrungsgewinnung),
                               Width => 1);
      New_Line;
            
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 21,
                                     LetzteZeileExtern      => 21,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Ressourcengewinnung),
                               Width => 1);
            
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 22,
                                     LetzteZeileExtern      => 22,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Geldgewinnung),
                               Width => 1);
            
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 23,
                                     LetzteZeileExtern      => 23,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Wissensgewinnung),
                               Width => 1);
      New_Line;
      
   end InformationenAllgemein;

end KarteInformationen;
