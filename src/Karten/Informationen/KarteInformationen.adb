pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleKonstanten, GlobaleTexte;

with Anzeige, Cheat, EinheitSuchen, StadtSuchen, KarteStadt, ForschungAllgemein, VerbesserungenAllgemein, KartenAllgemein, EinheitenAllgemein, StadtInformationen, GesamtwerteFeld, KampfwerteEinheitErmitteln,
     LeseEinheitenGebaut, LeseKarten, LeseEinheitenDatenbank, LeseStadtGebaut;

package body KarteInformationen is

   procedure KarteInformation
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin

      Verteidigungsbonus := GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                              RasseExtern       => RasseExtern);
      Nahrungsgewinnung := GesamtwerteFeld.FeldNahrung (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                        RasseExtern       => RasseExtern);
      Ressourcengewinnung := GesamtwerteFeld.FeldProduktion (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                             RasseExtern       => RasseExtern);
      Geldgewinnung := GesamtwerteFeld.FeldGeld (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                 RasseExtern       => RasseExtern);
      Wissensgewinnung := GesamtwerteFeld.FeldWissen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                      RasseExtern       => RasseExtern);      
      Angriffsbonus := GesamtwerteFeld.FeldAngriff (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                    RasseExtern       => RasseExtern);
      
      -- Allgemeine Informationen über die eigene Rasse, immer sichtbar
      InformationenRundenanzahl;
      InformationenGeldmenge (RasseExtern => RasseExtern);
      InformationenGeldGewinn (RasseExtern => RasseExtern);
      InformationenForschungsprojekt (RasseExtern => RasseExtern);
      InformationenForschungszeit (RasseExtern => RasseExtern);
      InformationenForschungsmenge (RasseExtern => RasseExtern);
      InformationenForschungsrate (RasseExtern => RasseExtern);
      
      case
        LeseKarten.Sichtbar (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                             RasseExtern    => RasseExtern)
      is
         when True =>
            EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
            
            if
              EinheitRasseNummer.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
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
               when GlobaleKonstanten.LeerEinheitStadtNummer =>
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
      
      -- Aktuelle Kartenposition
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 58,
                                     LetzteZeileExtern      => 58,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      Put_Line (Item => GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse'Wide_Wide_Image & "," & GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse'Wide_Wide_Image
                & "," & GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse'Wide_Wide_Image);
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
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
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
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
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
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
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
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      ForschungAllgemein.Beschreibung (IDExtern    => GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt);
      
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
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
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
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
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
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
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
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
            EinheitNummer := EinheitRasseNummerExtern.Platznummer;
                        
         when others =>
            EinheitNummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      EinheitenAllgemein.Beschreibung (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)));
      New_Line;
                  
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 14,
                                     LetzteZeileExtern      => 14,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))),
                               Width => 1);
      Put (Item => " / ");
      Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                               IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)))),
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
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Float_Text_IO.Put (Item => Float (LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))),
                                Fore => 1,
                                Aft  => 2,
                                Exp  => 0);
         Put (Item => " / ");
         Ada.Float_Text_IO.Put (Item => Float (LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                               IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)))),
                                Fore => 1,
                                Aft  => 2,
                                Exp  => 0);

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 16,
                                        LetzteZeileExtern      => 16,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))),
                                  Width => 1);
         Put (Item => " / ");
         Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)))),
                                  Width => 1);
         New_Line;
                              
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 17,
                                        LetzteZeileExtern      => 17,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         EinheitenAllgemein.Beschäftigung (LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)));

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 18,
                                        LetzteZeileExtern      => 18,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))),
                                  Width => 1);
         New_Line;

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 24,
                                        LetzteZeileExtern      => 24,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Integer_Text_IO.Put (Item  => Integer (LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                    IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)))),
                                  Width => 1);

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 25,
                                        LetzteZeileExtern      => 25,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Integer_Text_IO.Put (Item  => Integer (LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                         IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)))),
                                  Width => 1);
         
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 26,
                                        LetzteZeileExtern      => 26,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenGebaut.Rang (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))),
                                  Width => 1);
         Put (Item => " / ");
         Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                          IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)))),
                                  Width => 1);
         
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 52,
                                        LetzteZeileExtern      => 52,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         
         case
           LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when GlobaleKonstanten.LeerEinheitStadtNummer =>
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                              TextDateiExtern        => GlobaleTexte.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 53,
                                              LetzteZeileExtern      => 53,
                                              AbstandAnfangExtern    => GlobaleTexte.Leer,
                                              AbstandMitteExtern     => GlobaleTexte.Leer,
                                              AbstandEndeExtern      => GlobaleTexte.Leer);
               
            when others =>
               StadtInformationen.StadtName (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
         end case;
         New_Line;
         
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 60,
                                        LetzteZeileExtern      => 60,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Integer_Text_IO.Put (Item  => Integer (KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                            AngreiferExtern          => False)),
                                  Width => 1);

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Zeug,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 61,
                                        LetzteZeileExtern      => 61,
                                        AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         Ada.Integer_Text_IO.Put (Item  => Integer (KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                        AngreiferExtern          => False)),
                                  Width => 1);
                 
         case
           (LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))))
         is
            when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
               null;
               
            when others =>
               ErsteAnzeige := True;
               
               LadungSchleife:
               for LadungSchleifenwert in GlobaleRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                               IDExtern    =>
                                                                                                                                  LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) loop
                  
                  if
                    LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       PlatzExtern              => LadungSchleifenwert) /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
                    and
                      ErsteAnzeige
                  then
                     New_Line;
                     ErsteAnzeige := False;
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                                    TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
                                                    ÜberschriftZeileExtern => 51,
                                                    ErsteZeileExtern       =>
                                                      Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                     LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                        PlatzExtern              => LadungSchleifenwert)))),
                                                    LetzteZeileExtern      =>
                                                      Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                     LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                        PlatzExtern              => LadungSchleifenwert)))),
                                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                                    AbstandMitteExtern     => GlobaleTexte.Leer,
                                                    AbstandEndeExtern      => GlobaleTexte.Großer_Abstand);
                     
                  elsif
                    LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       PlatzExtern              => LadungSchleifenwert) /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
                  then
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                                    TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       =>
                                                      Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                     LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                        PlatzExtern              => LadungSchleifenwert)))),
                                                    LetzteZeileExtern      =>
                                                      Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                     LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                        PlatzExtern              => LadungSchleifenwert)))),
                                                    AbstandAnfangExtern    => GlobaleTexte.Leer,
                                                    AbstandMitteExtern     => GlobaleTexte.Leer,
                                                    AbstandEndeExtern      => GlobaleTexte.Großer_Abstand);
                     
                  else
                     null;
                  end if;
            
               end loop LadungSchleife;
         end case;         
         
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
        LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern) = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
      then
         KarteStadt.Beschreibung (RasseExtern            => RasseExtern,
                                  StadtRasseNummerExtern => StadtRasseNummerExtern);

         -- Debuginformationen, nur sichtbar wenn Cheat aktiviert ist
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
        LeseKarten.Hügel (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position) = True
        and
          LeseKarten.Grund (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position) /= GlobaleDatentypen.Hügel
      then
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Beschreibungen_Kartenfelder_Kurz,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => GlobaleDatentypen.Karten_Grund_Enum'Pos (GlobaleDatentypen.Hügel_Mit),
                                        LetzteZeileExtern      => GlobaleDatentypen.Karten_Grund_Enum'Pos (GlobaleDatentypen.Hügel_Mit),
                                        AbstandAnfangExtern    => GlobaleTexte.Leer,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Leer);
         KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Grund (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position));
         
      elsif
        LeseKarten.Hügel (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)
      then
         KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Grund (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position));
               
      else         
         KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Grund (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position));
      end if;
      
      if
        LeseKarten.Ressource (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position) /= GlobaleDatentypen.Leer
      then
         KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Ressource (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position));
         
      else
         null;
      end if;
      
      if
        LeseKarten.VerbesserungGebiet (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position) /= GlobaleDatentypen.Leer
      then
         VerbesserungenAllgemein.Beschreibung (KartenVerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position));
         
      else
         null;
      end if;
      
      if
        LeseKarten.VerbesserungWeg (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position) /= GlobaleDatentypen.Leer
      then
         VerbesserungenAllgemein.Beschreibung (KartenVerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position));
               
      else
         null;
      end if;
      
      if
        LeseKarten.Fluss (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position) /= GlobaleDatentypen.Leer
      then
         KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Fluss (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position));
         
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
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Verteidigungsbonus),
                               Width => 1);
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 59,
                                     LetzteZeileExtern      => 59,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Angriffsbonus),
                               Width => 1);
            
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 20,
                                     LetzteZeileExtern      => 20,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
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
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Ressourcengewinnung),
                               Width => 1);
            
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 22,
                                     LetzteZeileExtern      => 22,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Geldgewinnung),
                               Width => 1);
            
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 23,
                                     LetzteZeileExtern      => 23,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (Wissensgewinnung),
                               Width => 1);
      New_Line;
      
   end InformationenAllgemein;

end KarteInformationen;
