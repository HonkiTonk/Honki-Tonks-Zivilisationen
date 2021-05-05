pragma SPARK_Mode (On);

with GlobaleKonstanten;

with ForschungsDatenbank, InDerStadt, BewegungssystemEinheiten, BewegungssystemCursor, Auswahl, EinheitenDatenbank, NaechstesObjekt, Verbesserungen,
     Anzeige, Diplomatie, Cheat, StadtBauen, EinheitSuchen, StadtSuchen, Eingabe, FeldInformationen, OptionenSteuerung;

package body BefehleImSpiel is

   function Befehle
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return Integer
   is begin 
            
      Befehl := Eingabe.TastenEingabe;

      if -- Cursor bewegen
        Befehl = OptionenSteuerung.Tastenbelegung (1, 1)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 2)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 3)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 4)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 5)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 6)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 7)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 8)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 9)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 10)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 1)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 2)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 3)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 4)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 5)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 6)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 7)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 8)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 9)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 10)
      then
         BewegungssystemCursor.BewegungCursorRichtung (KarteExtern       => True,
                                                       RichtungExtern    => Befehl,
                                                       RasseExtern       => RasseExtern);
            
      elsif -- Auswählen
        Befehl = OptionenSteuerung.Tastenbelegung (1, 11)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 11)
      then
         EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                          KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
         StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                    KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);

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

            else
               if
                 GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).WirdTransportiert /= 0
               then
                  EinheitTransportNummer := EinheitenDatenbank.EinheitTransporterAuswählen (EinheitRasseNummerExtern => (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).WirdTransportiert));

               else
                  EinheitTransportNummer := EinheitenDatenbank.EinheitTransporterAuswählen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
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
            end if;
               
         else
            null;
         end if;
                 
      elsif -- Menüaufruf
        Befehl = OptionenSteuerung.Tastenbelegung (1, 12)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 12)
      then
         MenüAufruf := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Leer,
                                         TextDateiExtern   => GlobaleDatentypen.Menü_Auswahl,
                                         FrageZeileExtern  => 0,
                                         ErsteZeileExtern  => 1,
                                         LetzteZeileExtern => 6);
         return MenüAufruf;

      elsif -- Baue Stadt
        Befehl = OptionenSteuerung.Tastenbelegung (1, 13)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 13)
      then
         EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                          KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
         case
           EinheitNummer
         is
            when 0 =>
               null;
                  
            when others =>
               if 
                 EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).EinheitTyp = 1
                 and
                   GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte > 0.00
               then
                  Nullwert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
                     
               else
                  null;
               end if;
         end case;
           
      elsif -- Technologie/Forschung
        Befehl = OptionenSteuerung.Tastenbelegung (1, 14)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 14)
      then
         case
           GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt
         is
            when 0 =>
               ForschungsDatenbank.Forschung (RasseExtern => RasseExtern);
                     
            when others =>
               WahlForschung := Auswahl.AuswahlJaNein (FrageZeileExtern => 17);
               if
                 WahlForschung = GlobaleKonstanten.JaKonstante
               then
                  ForschungsDatenbank.Forschung (RasseExtern => RasseExtern);
                     
               else
                  null;
               end if;
         end case;
            
      elsif -- Anzeige des Forschungsbaums
        Befehl = OptionenSteuerung.Tastenbelegung (1, 15)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 15)
      then
         ForschungsDatenbank.ForschungsBaum (RasseExtern => RasseExtern);
            
      elsif -- Nächste Stadt
        Befehl = OptionenSteuerung.Tastenbelegung (1, 16)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 16)
      then
         NaechstesObjekt.NächsteStadt (RasseExtern => RasseExtern);
            
      elsif -- Einheiten mit Bewegungspunkten
        Befehl = OptionenSteuerung.Tastenbelegung (1, 17)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 17)
      then
         NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                          BewegungspunkteExtern => NaechstesObjekt.Hat_Bewegungspunkte);
            
      elsif -- Alle Einheiten
        Befehl = OptionenSteuerung.Tastenbelegung (1, 18)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 18)
      then
         NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                          BewegungspunkteExtern => NaechstesObjekt.Egal_Bewegeungspunkte);
            
      elsif -- Einheiten ohne Bewegungspunkte
        Befehl = OptionenSteuerung.Tastenbelegung (1, 19)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 19)
      then
         NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                          BewegungspunkteExtern => NaechstesObjekt.Keine_Bewegungspunkte);
            
      elsif -- 20 = Straße bauen, 21 = Mine bauen, 22 = Farm bauen, 23 = Festung bauen, 24 = Wald aufforsten, 25 = /Roden-Trockenlegen,
      -- 26 = Heilen, 27 = Verschanzen, 28 = Runde aussetzen, 29 = Einheit auflösen, 30 = Plündern
        Befehl = OptionenSteuerung.Tastenbelegung (1, 20)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 21)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 22)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 23)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 24)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 25)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 26)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 27)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 28)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 29)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (1, 30)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 20)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 21)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 22)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 23)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 24)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 25)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 26)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 27)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 28)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 29)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 30)
      then
         SteuerungAußenSchleife:
         for AußenSchleifenwert in OptionenSteuerung.Tastenbelegung'Range (1) loop
            SteuerungInnenSchleife:
            for BefehlSchleifenwert in OptionenSteuerung.Tastenbelegung'Range (2) loop
               
               if
                 Befehl = OptionenSteuerung.Tastenbelegung (AußenSchleifenwert, BefehlSchleifenwert)
               then
                  WelcherBefehl := BefehlSchleifenwert - GlobaleKonstanten.EinheitBefehlAbzug;
                  exit SteuerungAußenSchleife;
                  
               else
                  null;
               end if;
               
            end loop SteuerungInnenSchleife;
         end loop SteuerungAußenSchleife;
               
         EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                          KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
         case
           EinheitNummer
         is
            when 0 =>
               return 1;
                  
            when others =>
               null;
         end case;

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
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte = 0.00
         then
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                                  TextZeileExtern => 8);
                     
         else
            Verbesserungen.Verbesserung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer),
                                         BefehlExtern             => GlobaleDatentypen.Befehle_Enum'Val (WelcherBefehl));
         end if;
            
      elsif -- Informationen für Einheiten, Verbesserungen, usw.
        Befehl = OptionenSteuerung.Tastenbelegung (1, 31)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 31)
      then
         FeldInformationen.Aufteilung (RasseExtern => RasseExtern);

      elsif -- Diplomatie
        Befehl = OptionenSteuerung.Tastenbelegung (1, 32)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 32)
      then
         Diplomatie.DiplomatieAuswählen;

      elsif -- GeheZu Cursor
        Befehl = OptionenSteuerung.Tastenbelegung (1, 33)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 33)
      then
         BewegungssystemCursor.GeheZuCursor (RasseExtern => RasseExtern);

      elsif -- Stadt umbenennen
        Befehl = OptionenSteuerung.Tastenbelegung (1, 34)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 34)
      then
         StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                    KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
         case
           StadtNummer
         is
            when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
               null;
                  
            when others =>
               GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Name := Eingabe.StadtName;
         end case;
            
      elsif -- Stadt abreißen
        Befehl = OptionenSteuerung.Tastenbelegung (1, 35)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 35)
      then
         StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                    KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
         if
           StadtNummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
         then
            null;
               
         else
            AbreißenAuswahl := Auswahl.AuswahlJaNein (FrageZeileExtern => 7);
            case
              AbreißenAuswahl
            is
               when GlobaleKonstanten.JaKonstante =>
                  GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer) := GlobaleKonstanten.LeererWertStadt;
            
               when others =>
                  null;
            end case;                  
         end if;
            
      elsif -- Stadt mit Namen suchen
        Befehl = OptionenSteuerung.Tastenbelegung (1, 36)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 36)
      then
         StadtSuchenNachNamen := StadtSuchen.StadtNachNamenSuchen;
            
      elsif -- Runde beenden
        Befehl = OptionenSteuerung.Tastenbelegung (1, 37)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 37)
      then
         return -1_000;
            
      elsif -- Kleine Cheattaste
        Befehl = OptionenSteuerung.Tastenbelegung (1, 38)
        or
          Befehl = OptionenSteuerung.Tastenbelegung (2, 38)
      then
         Cheat.Menü (RasseExtern => RasseExtern);
            
      else
         null;
      end if;

      return 1;
      
   end Befehle;



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
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse := 1;
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse := 1;
            InDerStadt.InDerStadt (StadtRasseNummerExtern => (RasseExtern, StadtNummerExtern));
            
         when others =>
            if
              GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerExtern).AktuelleBeschäftigung /= GlobaleDatentypen.Keine
            then
               Wahl := EinheitenDatenbank.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (7);
               case
                 Wahl
               is
                  when True =>
                     GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerExtern).AktuelleBeschäftigung := GlobaleDatentypen.Keine;
                           
                  when False =>
                     null;
               end case;
                  
            elsif
              GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerExtern).AktuelleBewegungspunkte = 0.00
            then
               null;
                     
            else
               BewegungssystemEinheiten.BewegungEinheitenRichtung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern));
            end if;
      end case;
      
   end EinheitOderStadt;   

end BefehleImSpiel;
