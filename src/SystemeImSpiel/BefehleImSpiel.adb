pragma SPARK_Mode (On);

with Ada.Characters.Wide_Wide_Latin_9;
use Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with ForschungsDatenbank, InDerStadt, BewegungssystemEinheiten, BewegungssystemCursor, Auswahl, EinheitenDatenbank, NaechstesObjekt, Verbesserungen,
     Anzeige, Diplomatie, Cheat, StadtBauen, EinheitSuchen, StadtSuchen, Eingabe, FeldInformationen;

package body BefehleImSpiel is

   function Befehle
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return Integer
   is begin 
            
      Taste := Eingabe.TastenEingabe;

      case
        Taste
      is -- Cursor bewegen
         when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' | '+' | '-' =>
            BewegungssystemCursor.BewegungCursorRichtung (KarteExtern       => True,
                                                          RichtungExtern    => Taste,
                                                          RasseExtern       => RasseExtern);
            
         when 'e' | '5' => -- Einheit bewegen/Stadt betreten
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
                                                                        
         when 'q' => -- Menüaufruf
            MenüAufruf := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Leer,
                                            TextDateiExtern   => GlobaleDatentypen.Menü_Auswahl,
                                            FrageZeileExtern  => 0,
                                            ErsteZeileExtern  => 1,
                                            LetzteZeileExtern => 6);
            return MenüAufruf;

         when 'b' => -- Baue Stadt
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
            
         when 't' => -- Technologie/Forschung
            case
              GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt
            is
               when 0 =>
                  ForschungsDatenbank.Forschung (RasseExtern => RasseExtern);
                     
               when others =>
                  WahlForschung := Auswahl.AuswahlJaNein (FrageZeileExtern => 17);
                  case
                    WahlForschung
                  is
                     when GlobaleKonstanten.JaKonstante =>
                        ForschungsDatenbank.Forschung (RasseExtern => RasseExtern);
                     
                     when others =>
                        null;
                  end case;
            end case;
            
         when 'x' => -- Anzeige des Forschungsbaums
            ForschungsDatenbank.ForschungsBaum (RasseExtern => RasseExtern);
            
         when '/' => -- Nächste Stadt
            NaechstesObjekt.NächsteStadt (RasseExtern => RasseExtern);
            
         when '.' => -- Einheiten mit Bewegungspunkten
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Hat_Bewegungspunkte);
            
         when '*' => -- Alle Einheiten
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Egal_Bewegeungspunkte);
            
         when ',' => -- Einheiten ohne Bewegungspunkte
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Keine_Bewegungspunkte);
            
         when 'l' | 'm' | 'f' | 'u' | 'z' | 'p' | 'h' | 'v' | Space | DEL | 'j' => -- l/1 = Straße, m/2 = Mine, f/3 = Farm, u/4 = Festung, z/5 = Wald aufforsten, p/6 = /Roden-Trockenlegen,
            -- h/7 = Heilen, v/8 = Verschanzen, Space/9 = Runde aussetzen, DEL/10 = Einheit auflösen, j/11 = Plündern
            case
              Taste
            is
               when 'l' =>
                  WelcherBefehl := 1;
                  
               when 'm' =>
                  WelcherBefehl := 2;
                  
               when 'f' =>
                  WelcherBefehl := 3;
                  
               when 'u' =>
                  WelcherBefehl := 4;
                  
               when 'z' =>
                  WelcherBefehl := 5;
                  
               when 'p' =>
                  WelcherBefehl := 6;
                  
               when 'h' =>
                  WelcherBefehl := 7;
                  
               when 'v' =>
                  WelcherBefehl := 8;

               when Space =>
                  WelcherBefehl := 9;
                  
               when DEL =>
                  WelcherBefehl := 10;

               when 'j' =>
                  WelcherBefehl := 11;
                  
               when others =>
                  return 1;
            end case;
               
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
            
         when 'i' => -- Informationen für Einheiten, Verbesserungen, usw.
            FeldInformationen.Aufteilung (RasseExtern => RasseExtern);

         when '#' => -- Diplomatie
            Diplomatie.DiplomatieAuswählen;

         when 'g' => -- GeheZu Cursor
            BewegungssystemCursor.GeheZuCursor (RasseExtern => RasseExtern);

         when 'n' => -- Stadt umbenennen
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
            
         when 'k' => -- Stadt abreißen
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
            
         when 'y' => -- Stadt mit Namen suchen
            StadtSuchenNachNamen := StadtSuchen.StadtNachNamenSuchen;
            
         when 'r' => -- Runde beenden
            return -1_000;
            
         when 'c' => -- Kleine Cheattaste
            Cheat.Menü (RasseExtern => RasseExtern);
            
         when others =>
            null;
      end case;

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
