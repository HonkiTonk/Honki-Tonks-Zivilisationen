pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with EinheitenKonstanten;
with StadtKonstanten;
with GlobaleVariablen;
with SystemKonstanten;

with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseWichtiges;

with InDerStadt;
with BewegungCursor;
with Auswahl;
with NaechstesObjekt;
with Aufgaben;
with Anzeige;
with Diplomatie;
with Cheat;
with StadtBauen;
with EinheitSuchen;
with StadtSuchen;
with Eingabe;
with ForschungAllgemein;
with StadtEntfernen;
with EinheitenTransporter;
with TransporterSuchen;
with EinheitenBeschreibungen;
with EinheitenModifizieren;
with AufgabenAllgemein;
with BewegungEinheitenSFML;

package body BefehleSFML is
   
   function BefehleSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      Befehl := Eingabe.Tastenwert;

      case
        Befehl
      is
         when SystemDatentypen.Tastenbelegung_Bewegung_Enum'Range =>
            BewegungCursor.BewegungCursorRichtung (KarteExtern    => True,
                                                   RichtungExtern => Befehl,
                                                   RasseExtern    => RasseExtern);
            
         when SystemDatentypen.Auswählen =>
            AuswahlMaus (RasseExtern => RasseExtern);
                 
         when SystemDatentypen.Menü_Zurück =>
            return SystemDatentypen.Spielmenü;

         when SystemDatentypen.Bauen =>
            BaueStadt (RasseExtern => RasseExtern);
           
         when SystemDatentypen.Forschung =>
            Technologie (RasseExtern => RasseExtern);
            
         when SystemDatentypen.Tech_Baum =>
            -- Kann in der SMFL Version ignoriert werden oder das auch in der Konsolenversion ändern und den Befehl komplett wegwerfen?
            -- ForschungAllgemein.ForschungsBaum (RasseExtern => RasseExtern);
            null;
            
         when SystemDatentypen.Nächste_Stadt =>
            NaechstesObjekt.NächsteStadt (RasseExtern => RasseExtern);
            
         when SystemDatentypen.Einheit_Mit_Bewegungspunkte =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Hat_Bewegungspunkte);
            
         when SystemDatentypen.Alle_Einheiten =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Egal_Bewegeungspunkte);
            
         when SystemDatentypen.Einheiten_Ohne_Bewegungspunkte =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Keine_Bewegungspunkte);
            
         when SystemDatentypen.Tastenbelegung_Befehle_Enum'Range =>
            EinheitBefehle (RasseExtern  => RasseExtern,
                            BefehlExtern => Befehl);
            
         when SystemDatentypen.Infos =>
            -- Hier mal was reinbauen.
            null;

         when SystemDatentypen.Diplomatie =>
            Diplomatie.DiplomatieMöglich (RasseExtern => RasseExtern);

         when SystemDatentypen.GeheZu =>
            BewegungCursor.GeheZuCursor (RasseExtern => RasseExtern);

         when SystemDatentypen.Stadt_Umbenennen =>
            StadtUmbenennen (RasseExtern => RasseExtern);
            
         when SystemDatentypen.Stadt_Abreißen =>
            StadtAbreißen (RasseExtern => RasseExtern);
            
         when SystemDatentypen.Stadt_Suchen =>
            StadtSuchenNachNamen := StadtSuchen.StadtNachNamenSuchen;
            
         when SystemDatentypen.Nächste_Stadt_Mit_Meldung =>
            NaechstesObjekt.NächsteStadtMeldung (RasseExtern => RasseExtern);
            
         when SystemDatentypen.Nächste_Einheit_Mit_Meldung =>
            NaechstesObjekt.NächsteEinheitMeldung (RasseExtern => RasseExtern);
            
         when SystemDatentypen.Heimatstadt_Ändern =>
            EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => (RasseExtern, 0));
            
         when SystemDatentypen.Runde_Beenden =>
            return SystemKonstanten.RundeBeendenKonstante;
            
         when SystemDatentypen.Cheatmenü =>
            Cheat.Menü (RasseExtern => RasseExtern);
            
         when SystemDatentypen.Leer =>
            null;
      end case;

      return SystemKonstanten.StartWeiterKonstante;
      
   end BefehleSFML;
   
   
   
   procedure AuswahlMaus
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Hier später auf alles prüfen.
      AuswahlEinheitStadt (RasseExtern => RasseExtern);
      
   end AuswahlMaus;
   
   
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);

      if
        EinheitNummer /= EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First
        and
          StadtNummer /= EinheitStadtDatentypen.MaximaleStädteMitNullWert'First
      then
         EinheitOderStadt (RasseExtern         => RasseExtern,
                           AuswahlExtern       => Auswahl.AuswahlJaNein (FrageZeileExtern => 15),
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);
         
      elsif
        StadtNummer /= EinheitStadtDatentypen.MaximaleStädteMitNullWert'First
      then
         EinheitOderStadt (RasseExtern         => RasseExtern,
                           AuswahlExtern       => SystemKonstanten.JaKonstante,
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);
         
      elsif
        EinheitNummer /= EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First
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
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerWirdTransportiert
        and
          Transportiert = False
      then
         EinheitTransportNummer := EinheitRasseNummerExtern.Platznummer;

      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerWirdTransportiert
      then
         EinheitTransportNummer:= EinheitenTransporter.EinheitTransporterAuswählen (EinheitRasseNummerExtern =>
                                                                                       (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));

      else
         EinheitTransportNummer := EinheitenTransporter.EinheitTransporterAuswählen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
      case
        EinheitTransportNummer
      is
         when EinheitenKonstanten.LeerNummer =>
            null;
                        
         when others =>
            EinheitOderStadt (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                              AuswahlExtern       => SystemKonstanten.NeinKonstante,
                              StadtNummerExtern   => EinheitStadtDatentypen.MaximaleStädteMitNullWert'First,
                              EinheitNummerExtern => EinheitTransportNummer);
      end case;
      
   end AuswahlEinheitTransporter;



   procedure EinheitOderStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      AuswahlExtern : in SystemDatentypen.Rückgabe_Werte_Enum;
      StadtNummerExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheitenMitNullWert)
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
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= SystemDatentypen.Leer
        and then
          EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (7) = True
      then
         AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  
      elsif
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerEinheit.Bewegungspunkte
      then
         null;
                     
      else
         BewegungEinheitenSFML.BewegungEinheitenRichtung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end EinheitSteuern;
   
   
   
   procedure BaueStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      case
        EinheitNummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer)) > EinheitenKonstanten.LeerEinheit.Bewegungspunkte
      then
         NullWert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
                     
      else
         null;
      end if;
      
   end BaueStadt;
   
   
   
   procedure Technologie
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern)
      is
         when EinheitStadtDatentypen.ForschungIDMitNullWert'First =>
            ForschungAllgemein.Forschung (RasseExtern => RasseExtern);
            return;
            
         when others =>
            null;
      end case;
          
      -- Aktuell keine Sicherheitsabfrage aktiv.
      --  case
      --    Auswahl.AuswahlJaNein (FrageZeileExtern => 17)
      --  is
      --     when SystemKonstanten.JaKonstante =>
      ForschungAllgemein.Forschung (RasseExtern => RasseExtern);
                     
      --     when others =>
      --       null;
      --  end case;
      
   end Technologie;
   
   
   
   procedure EinheitBefehle
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Befehle_Enum)
   is begin
                     
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      if
        EinheitNummer = EinheitenKonstanten.LeerNummer
      then
         return;
                  
      else
         null;
      end if;
            
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer)) = EinheitenKonstanten.LeerEinheit.Bewegungspunkte
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
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      
      if
        StadtNummer = StadtKonstanten.LeerNummer
      then
         null;
         
      else
         NeuerName := Eingabe.StadtName;
         
         case
           NeuerName.ErfolgreichAbbruch
         is
            when False =>
               null;
               
            when True =>
               SchreibeStadtGebaut.Name (StadtRasseNummerExtern => (RasseExtern, StadtNummer),
                                         NameExtern             => NeuerName.EingegebenerText);
         end case;
      end if;
      
   end StadtUmbenennen;
   
   
   
   procedure StadtAbreißen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
      case
        StadtNummer
      is
         when StadtKonstanten.LeerNummer =>
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

end BefehleSFML;
