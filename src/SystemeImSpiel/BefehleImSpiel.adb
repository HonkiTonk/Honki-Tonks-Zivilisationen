pragma SPARK_Mode (On);

with GlobaleTexte;

with InDerStadt, BewegungssystemEinheiten, BewegungssystemCursor, Auswahl, NaechstesObjekt, Verbesserungen, Anzeige, Diplomatie, Cheat, StadtBauen, EinheitSuchen, StadtSuchen,
     Eingabe, FeldInformationen, ForschungAllgemein, EinheitenAllgemein, StadtEntfernen, LeseEinheitenGebaut, SchreibeEinheitenGebaut;

package body BefehleImSpiel is

   function Befehle
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin 
      
      Befehl := Eingabe.Tastenwert;

      case
        Befehl
      is
         when GlobaleDatentypen.Tastenbelegung_Bewegung_Enum'Range =>
            BewegungssystemCursor.BewegungCursorRichtung (KarteExtern    => True,
                                                          RichtungExtern => Befehl,
                                                          RasseExtern    => RasseExtern);
            
         when GlobaleDatentypen.Auswählen =>
            AuswahlEinheitStadt (RasseExtern => RasseExtern);
                 
         when GlobaleDatentypen.Menü_Zurück =>
            return Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Leer,
                                    TextDateiExtern   => GlobaleTexte.Menü_Auswahl,
                                    FrageZeileExtern  => 0,
                                    ErsteZeileExtern  => 1,
                                    LetzteZeileExtern => 6);

         when GlobaleDatentypen.Bauen =>
            BaueStadt (RasseExtern => RasseExtern);
           
         when GlobaleDatentypen.Forschung =>
            Technologie (RasseExtern => RasseExtern);
            
         when GlobaleDatentypen.Tech_Baum =>
            ForschungAllgemein.ForschungsBaum (RasseExtern => RasseExtern);
            
         when GlobaleDatentypen.Nächste_Stadt =>
            NaechstesObjekt.NächsteStadt (RasseExtern => RasseExtern);
            
         when GlobaleDatentypen.Einheit_Mit_Bewegungspunkte =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Hat_Bewegungspunkte);
            
         when GlobaleDatentypen.Alle_Einheiten =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Egal_Bewegeungspunkte);
            
         when GlobaleDatentypen.Einheiten_Ohne_Bewegungspunkte =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Keine_Bewegungspunkte);
            
         when GlobaleDatentypen.Tastenbelegung_Befehle_Enum'Range =>                     
            EinheitBefehle (RasseExtern  => RasseExtern,
                            BefehlExtern => Befehl);
            
         when GlobaleDatentypen.Infos =>
            FeldInformationen.Aufteilung (RasseExtern => RasseExtern);

         when GlobaleDatentypen.Diplomatie =>
            Diplomatie.DiplomatieMöglich (RasseExtern => RasseExtern);

         when GlobaleDatentypen.GeheZu =>
            BewegungssystemCursor.GeheZuCursor (RasseExtern => RasseExtern);

         when GlobaleDatentypen.Stadt_Umbenennen =>
            StadtUmbenennen (RasseExtern => RasseExtern);
            
         when GlobaleDatentypen.Stadt_Abreißen =>
            StadtAbreißen (RasseExtern => RasseExtern);
            
         when GlobaleDatentypen.Stadt_Suchen =>
            StadtSuchenNachNamen := StadtSuchen.StadtNachNamenSuchen;
            
         when GlobaleDatentypen.Nächste_Stadt_Mit_Meldung =>
            NaechstesObjekt.NächsteStadtMeldung (RasseExtern => RasseExtern);
            
         when GlobaleDatentypen.Nächste_Einheit_Mit_Meldung =>
            NaechstesObjekt.NächsteEinheitMeldung (RasseExtern => RasseExtern);
            
         when GlobaleDatentypen.Heimatstadt_Ändern =>
            EinheitenAllgemein.HeimatstadtÄndern (EinheitRasseNummerExtern => (RasseExtern, 0));
            
         when GlobaleDatentypen.Runde_Beenden =>
            return GlobaleKonstanten.RundeBeendenKonstante;
            
         when GlobaleDatentypen.Cheatmenü =>
            Cheat.Menü (RasseExtern => RasseExtern);
         
         when GlobaleDatentypen.Nicht_Vorhanden =>
            null;
      end case;

      return 1;
      
   end Befehle;
   
   
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
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
         Transportiert := EinheitSuchen.HatTransporterLadung (EinheitRassePlatznummerExtern => (RasseExtern, EinheitNummer));
         if
           LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer)) = GlobaleKonstanten.LeerTransportiertWirdTransportiert
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
           LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer)) /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
         then
            EinheitTransportNummer
              := EinheitenAllgemein.EinheitTransporterAuswählen (EinheitRasseNummerExtern => (RasseExtern, LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer))));

         else
            EinheitTransportNummer := EinheitenAllgemein.EinheitTransporterAuswählen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
         end if;
                  
         case
           EinheitTransportNummer
         is
            when GlobaleKonstanten.LeerEinheitStadtNummer =>
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
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
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
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern)) /= GlobaleDatentypen.Nicht_Vorhanden
        and then
          EinheitenAllgemein.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (7) = True
      then
         SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern),
                                                 BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
                  
      elsif
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern)) = GlobaleKonstanten.LeerEinheit.Bewegungspunkte
      then
         null;
                     
      else
         BewegungssystemEinheiten.BewegungEinheitenRichtung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern));
      end if;
      
   end EinheitOderStadt;
   
   
   
   procedure BaueStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      case
        EinheitNummer
      is
         when GlobaleKonstanten.LeerEinheitStadtNummer =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer)) > GlobaleKonstanten.LeerEinheit.Bewegungspunkte
      then
         StadtBauen.StadtBauen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
                     
      else
         null;
      end if;
      
   end BaueStadt;
   
   
   
   procedure Technologie
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
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
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in GlobaleDatentypen.Tastenbelegung_Befehle_Enum)
   is begin
                     
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      if
        EinheitNummer = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         return;
                  
      else
         null;
      end if;
            
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer)) = GlobaleKonstanten.LeerEinheit.Bewegungspunkte
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                               TextZeileExtern => 8);
         AufgabeDurchführen := False;
                     
      else
         AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer),
                                                                    BefehlExtern             => BefehlExtern);
      end if;
      
      case
        AufgabeDurchführen
      is
         when False =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                  TextZeileExtern => 2);
            
         when True =>
            null;
      end case;
      
   end EinheitBefehle;
   
   
   
   procedure StadtUmbenennen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      if
        StadtNummer = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         null;
                  
      else
         GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Name := Eingabe.StadtName;
      end if;
      
   end StadtUmbenennen;
   
   
   
   procedure StadtAbreißen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      case
        StadtNummer
      is
         when GlobaleKonstanten.LeerEinheitStadtNummer =>
            return;
            
         when others =>
            null;
      end case;
         
      AbreißenAuswahl := Auswahl.AuswahlJaNein (FrageZeileExtern => 30);
      case
        AbreißenAuswahl
      is
         when GlobaleKonstanten.JaKonstante =>
            StadtEntfernen.StadtEntfernen (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
            
         when others =>
            null;
      end case;
      
   end StadtAbreißen;

end BefehleImSpiel;
