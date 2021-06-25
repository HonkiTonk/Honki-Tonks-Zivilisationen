pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitenDatenbank;

with InDerStadt, BewegungssystemEinheiten, BewegungssystemCursor, Auswahl, NaechstesObjekt, Verbesserungen, Anzeige, Diplomatie, Cheat, StadtBauen, EinheitSuchen, StadtSuchen,
     Eingabe, FeldInformationen, ForschungAllgemein, EinheitenAllgemein;

package body BefehleImSpiel is

   function Befehle
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return Integer
   is begin 
      
      Befehl := Eingabe.Tastenwert;

      case
        Befehl
      is
         when 1 .. 10 =>
            -- Cursor bewegen
            BewegungssystemCursor.BewegungCursorRichtung (KarteExtern       => True,
                                                          RichtungExtern    => Befehl,
                                                          RasseExtern       => RasseExtern);
            
         when 11 =>
            -- Auswählen
            AuswahlEinheitStadt (RasseExtern => RasseExtern);
                 
         when 12 =>
            -- Menüaufruf
            return Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Leer,
                                    TextDateiExtern   => GlobaleDatentypen.Menü_Auswahl,
                                    FrageZeileExtern  => 0,
                                    ErsteZeileExtern  => 1,
                                    LetzteZeileExtern => 6);

         when 13 =>
            -- Baue Stadt
            BaueStadt (RasseExtern => RasseExtern);
           
         when 14 =>
            -- Technologie/Forschung
            Technologie (RasseExtern => RasseExtern);
            
         when 15 =>
            -- Anzeige des Forschungsbaums
            ForschungAllgemein.ForschungsBaum (RasseExtern => RasseExtern);
            
         when 16 =>
            -- Nächste Stadt
            NaechstesObjekt.NächsteStadt (RasseExtern => RasseExtern);
            
         when 17 =>
            -- Einheiten mit Bewegungspunkten
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Hat_Bewegungspunkte);
            
         when 18 =>
            -- Alle Einheiten
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Egal_Bewegeungspunkte);
            
         when 19 =>
            -- Einheiten ohne Bewegungspunkte
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Keine_Bewegungspunkte);
            
         when 20 .. 30 =>
            -- 20 = Straße bauen, 21 = Mine bauen, 22 = Farm bauen, 23 = Festung bauen, 24 = Wald aufforsten, 25 = /Roden-Trockenlegen,
            -- 26 = Heilen, 27 = Verschanzen, 28 = Runde aussetzen, 29 = Einheit auflösen, 30 = Plündern                          
            EinheitBefehle (RasseExtern => RasseExtern);
            
         when 31 => -- Informationen für Einheiten, Verbesserungen, usw.
            FeldInformationen.Aufteilung (RasseExtern => RasseExtern);

         when 32 =>
            -- Diplomatie
            Diplomatie.DiplomatieAuswählen (RasseExtern => RasseExtern);

         when 33 =>
            -- GeheZu Cursor
            BewegungssystemCursor.GeheZuCursor (RasseExtern => RasseExtern);

         when 34 =>
            -- Stadt umbenennen
            StadtUmbenennen (RasseExtern => RasseExtern);
            
         when 35 =>
            -- Stadt abreißen
            StadtAbreißen (RasseExtern => RasseExtern);
            
         when 36 =>
            -- Stadt mit Namen suchen
            StadtSuchenNachNamen := StadtSuchen.StadtNachNamenSuchen;
            
         when 37 =>
            -- Runde beenden
            return -1_000;
            
         when 38 =>
            -- Kleine Cheattaste
            Cheat.Menü (RasseExtern => RasseExtern);
            
         when 39 =>
            -- Meldungen von Städte
            null;
            
         when 40 =>
            -- Meldungen von Einheiten
            null;
            
         when others =>
            null;
      end case;

      return 1;
      
   end Befehle;
   
   
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);

      if
        EinheitNummer /= 0
        and
          StadtNummer /= 0
      then
         StadtOderEinheit := Auswahl.AuswahlJaNein (FrageZeileExtern => 15);

         EinheitOderStadt (RasseExtern         => RasseExtern,
                           AuswahlExtern       => StadtOderEinheit,
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);               
         
      elsif
        StadtNummer /= 0
      then
         EinheitOderStadt (RasseExtern         => RasseExtern,
                           AuswahlExtern       => GlobaleKonstanten.JaKonstante,
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);
         
      elsif
        EinheitNummer /= 0
      then
         Transportiert := EinheitSuchen.IstEinheitAufTransporter (EinheitRassePlatznummer => (RasseExtern, EinheitNummer));
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).WirdTransportiert = 0
           and
             Transportiert = False
         then
            EinheitOderStadt (RasseExtern         => RasseExtern,
                              AuswahlExtern       => GlobaleKonstanten.NeinKonstante,
                              StadtNummerExtern   => StadtNummer,
                              EinheitNummerExtern => EinheitNummer);
            return;

         else
            null;
         end if;
         
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).WirdTransportiert /= 0
         then
            EinheitTransportNummer := EinheitenAllgemein.EinheitTransporterAuswählen (EinheitRasseNummerExtern => (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).WirdTransportiert));

         else
            EinheitTransportNummer := EinheitenAllgemein.EinheitTransporterAuswählen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
         end if;
                  
         case
           EinheitTransportNummer
         is
            when 0 =>
               null;
                        
            when others =>
               EinheitOderStadt (RasseExtern         => RasseExtern,
                                 AuswahlExtern       => GlobaleKonstanten.NeinKonstante,
                                 StadtNummerExtern   => StadtNummer,
                                 EinheitNummerExtern => EinheitTransportNummer);
         end case;
               
      else
         null;
      end if;
      
   end AuswahlEinheitStadt;



   procedure EinheitOderStadt
     (RasseExtern : in GlobaleDatentypen.Rassen;
      AuswahlExtern : in Integer;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      case
        AuswahlExtern
      is
         when GlobaleKonstanten.JaKonstante =>
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse := 1;
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse := 1;
            InDerStadt.InDerStadt (StadtRasseNummerExtern => (RasseExtern, StadtNummerExtern));
            return;
            
         when others =>
            null;
      end case;
      
      if
        GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerExtern).Beschäftigung /= GlobaleDatentypen.Keine
        and then
          EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (7) = True
      then
         GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerExtern).Beschäftigung := GlobaleDatentypen.Keine;
                  
      elsif
        GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerExtern).Bewegungspunkte = 0.00
      then
         null;
                     
      else
         BewegungssystemEinheiten.BewegungEinheitenRichtung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern));
      end if;
      
   end EinheitOderStadt;
   
   
   
   procedure BaueStadt
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      case
        EinheitNummer
      is
         when 0 =>
            return;
            
         when others =>
            null;
      end case;
      
      if 
        EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).EinheitTyp = 1
        and
          GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).Bewegungspunkte > 0.00
      then
         StadtBauen.StadtBauen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
                     
      else
         null;
      end if;
      
   end BaueStadt;
   
   
   
   procedure Technologie
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      case
        GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt
      is
         when 0 =>
            ForschungAllgemein.Forschung (RasseExtern => RasseExtern);
            return;
            
         when others =>
            null;
      end case;
                    
      case
        Auswahl.AuswahlJaNein (FrageZeileExtern => 17)
      is
         when GlobaleKonstanten.JaKonstante =>
            ForschungAllgemein.Forschung (RasseExtern => RasseExtern);
                     
         when others =>
            null;
      end case;
      
   end Technologie;
   
   
   
   procedure EinheitBefehle
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      -- 20 = Straße bauen, 21 = Mine bauen, 22 = Farm bauen, 23 = Festung bauen, 24 = Wald aufforsten, 25 = /Roden-Trockenlegen,
      -- 26 = Heilen, 27 = Verschanzen, 28 = Runde aussetzen, 29 = Einheit auflösen, 30 = Plündern
      WelcherBefehl := Befehl - GlobaleKonstanten.EinheitBefehlAbzug;
               
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      if
        EinheitNummer = 0
      then
         return;
                  
      else
         null;
      end if;

      if
        GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID /= 1
        and
          WelcherBefehl <= 6
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                               TextZeileExtern => 3);

      elsif
        GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID = 1
        and
          WelcherBefehl = 11
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                               TextZeileExtern => 3);
                     
      elsif
        GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).Bewegungspunkte = 0.00
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                               TextZeileExtern => 8);
                     
      else
         Verbesserungen.Verbesserung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer),
                                      BefehlExtern             => GlobaleDatentypen.Befehle_Enum'Val (WelcherBefehl));
      end if;
      
   end EinheitBefehle;
   
   
   
   procedure StadtUmbenennen
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      if
        StadtNummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
      then
         null;
                  
      else
         GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Name := Eingabe.StadtName;
      end if;
      
   end StadtUmbenennen;
   
   
   
   procedure StadtAbreißen
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      case
        StadtNummer
      is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            return;
            
         when others =>
            null;
      end case;
         
      AbreißenAuswahl := Auswahl.AuswahlJaNein (FrageZeileExtern => 30);
      case
        AbreißenAuswahl
      is
         when GlobaleKonstanten.JaKonstante =>
            GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer) := GlobaleKonstanten.LeererWertStadt;
            
         when others =>
            null;
      end case;
      
   end StadtAbreißen;

end BefehleImSpiel;
