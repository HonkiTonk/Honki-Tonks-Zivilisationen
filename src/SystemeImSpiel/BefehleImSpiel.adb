pragma SPARK_Mode (On);

with GlobaleTexte, GlobaleKonstanten;

with SchreibeStadtGebaut;
with LeseEinheitenGebaut, LeseWichtiges;

with InDerStadt, BewegungEinheiten, BewegungCursor, Auswahl, NaechstesObjekt, Aufgaben, Anzeige, Diplomatie, Cheat, StadtBauen, EinheitSuchen, StadtSuchen, Eingabe, ForschungAllgemein,
     StadtEntfernen, EinheitenTransporter, TransporterSuchen, EinheitenBeschreibungen, EinheitenModifizieren, AufgabenAllgemein;

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
            BewegungCursor.BewegungCursorRichtung (KarteExtern    => True,
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
            -- Hier mal was reinbauen.
            null;

         when GlobaleDatentypen.Diplomatie =>
            Diplomatie.DiplomatieMöglich (RasseExtern => RasseExtern);

         when GlobaleDatentypen.GeheZu =>
            BewegungCursor.GeheZuCursor (RasseExtern => RasseExtern);

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
            EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => (RasseExtern, 0));
            
         when GlobaleDatentypen.Runde_Beenden =>
            return SystemKonstanten.RundeBeendenKonstante;
            
         when GlobaleDatentypen.Cheatmenü =>
            Cheat.Menü (RasseExtern => RasseExtern);
         
         when GlobaleDatentypen.Leer =>
            null;
      end case;

      return SystemKonstanten.StartNormalKonstante;
      
   end Befehle;
   
   
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);

      if
        EinheitNummer /= GlobaleDatentypen.MaximaleEinheitenMitNullWert'First
        and
          StadtNummer /= GlobaleDatentypen.MaximaleStädteMitNullWert'First
      then
         EinheitOderStadt (RasseExtern         => RasseExtern,
                           AuswahlExtern       => Auswahl.AuswahlJaNein (FrageZeileExtern => 15),
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);
         
      elsif
        StadtNummer /= GlobaleDatentypen.MaximaleStädteMitNullWert'First
      then
         EinheitOderStadt (RasseExtern         => RasseExtern,
                           AuswahlExtern       => SystemKonstanten.JaKonstante,
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);
         
      elsif
        EinheitNummer /= GlobaleDatentypen.MaximaleEinheitenMitNullWert'First
      then
         AuswahlEinheitTransporter (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
               
      else
         null;
      end if;
      
   end AuswahlEinheitStadt;
   
   
   
   procedure AuswahlEinheitTransporter
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Transportiert := TransporterSuchen.HatTransporterLadung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleKonstanten.LeerTransportiertWirdTransportiert
        and
          Transportiert = False
      then
         EinheitTransportNummer := EinheitRasseNummerExtern.Platznummer;

      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
      then
         EinheitTransportNummer:= EinheitenTransporter.EinheitTransporterAuswählen (EinheitRasseNummerExtern =>
                                                                                       (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));

      else
         EinheitTransportNummer := EinheitenTransporter.EinheitTransporterAuswählen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
      case
        EinheitTransportNummer
      is
         when GlobaleKonstanten.LeerEinheitStadtNummer =>
            null;
                        
         when others =>
            EinheitOderStadt (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                              AuswahlExtern       => SystemKonstanten.NeinKonstante,
                              StadtNummerExtern   => GlobaleDatentypen.MaximaleStädteMitNullWert'First,
                              EinheitNummerExtern => EinheitTransportNummer);
      end case;
      
   end AuswahlEinheitTransporter;



   procedure EinheitOderStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      AuswahlExtern : in Integer;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      case
        AuswahlExtern
      is
         when SystemKonstanten.JaKonstante =>
            StadtBetreten (StadtRasseNummerExtern => (RasseExtern, StadtNummerExtern));
            
         when others =>
            EinheitSteuern (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern));
      end case;
      
   end EinheitOderStadt;
   
   
   
   procedure StadtBetreten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse := 1;
      GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse := 1;
      InDerStadt.InDerStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end StadtBetreten;
   
   
   
   procedure EinheitSteuern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= GlobaleDatentypen.Leer
        and then
          EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (7) = True
      then
         AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  
      elsif
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleKonstanten.LeerEinheit.Bewegungspunkte
      then
         null;
                     
      else
         BewegungEinheiten.BewegungEinheitenRichtung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end EinheitSteuern;
   
   
   
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
         NullWert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
                     
      else
         null;
      end if;
      
   end BaueStadt;
   
   
   
   procedure Technologie
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern)
      is
         when GlobaleDatentypen.ForschungIDMitNullWert'First =>
            ForschungAllgemein.Forschung (RasseExtern => RasseExtern);
            return;
            
         when others =>
            null;
      end case;
                    
      case
        Auswahl.AuswahlJaNein (FrageZeileExtern => 17)
      is
         when SystemKonstanten.JaKonstante =>
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
         AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer),
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
         SchreibeStadtGebaut.Name (StadtRasseNummerExtern => (RasseExtern, StadtNummer),
                                   NameExtern             => Eingabe.StadtName);
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
         
      case
        Auswahl.AuswahlJaNein (FrageZeileExtern => 30)
      is
         when SystemKonstanten.JaKonstante =>
            StadtEntfernen.StadtEntfernen (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
            
         when others =>
            null;
      end case;
      
   end StadtAbreißen;

end BefehleImSpiel;
