pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;
with GlobaleVariablen;
with SystemKonstanten;
with TastenbelegungKonstanten;

with SchreibeStadtGebaut;
with LeseEinheitenGebaut;

with InDerStadt;
with BewegungCursor;
with NaechstesObjekt;
with Aufgaben;
with Diplomatie;
with DebugPlatzhalter;
with StadtBauen;
with EinheitSuchen;
with StadtSuchen;
with Eingabe;
with ForschungAllgemein;
with StadtEntfernen;
with TransporterSuchen;
with EinheitenBeschreibungen;
with EinheitenModifizieren;
with AufgabenAllgemein;
with BewegungEinheitenSFML;
with AuswahlStadtEinheit;

package body BefehleSFML is
   
   function BefehleSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      Befehl := Eingabe.Tastenwert;

      case
        Befehl
      is
         when TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum'Range =>
            BewegungCursor.BewegungCursorRichtung (KarteExtern    => True,
                                                   RichtungExtern => Befehl,
                                                   RasseExtern    => RasseExtern);
            
         when TastenbelegungKonstanten.AuswählenKonstante =>
            AuswahlEinheitStadt (RasseExtern => RasseExtern);
                 
         when TastenbelegungKonstanten.MenüZurückKonstante =>
            return SystemKonstanten.SpielmenüKonstante;

         when TastenbelegungKonstanten.BauenKonstante =>
            BaueStadt (RasseExtern => RasseExtern);
           
         when TastenbelegungKonstanten.ForschungKonstante =>
            ForschungAllgemein.Forschung (RasseExtern => RasseExtern);
            
         when TastenbelegungKonstanten.TechBaumKonstante =>
            -- Kann in der SMFL Version ignoriert werden oder das auch in der Konsolenversion ändern und den Befehl komplett wegwerfen?
            -- ForschungAllgemein.ForschungsBaum (RasseExtern => RasseExtern);
            null;
            
            -- Die folgenden vier Befehle scheinen gar nicht mehr zu funktionieren.
            -- genau wie bei GeheZu könnte es eventuell helfen nicht den Cursor zu platzieren sondern den Rendermittelpunkt dahin zu verschieben.
         when TastenbelegungKonstanten.NächsteStadtKonstante =>
            NaechstesObjekt.NächsteStadt (RasseExtern => RasseExtern);
            
         when TastenbelegungKonstanten.EinheitMitBewegungspunkteKonstante =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Hat_Bewegungspunkte);
            
         when TastenbelegungKonstanten.AlleEinheitenKonstante =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Egal_Bewegeungspunkte);
            
         when TastenbelegungKonstanten.EinheitenOhneBewegungspunkteKonstante =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Keine_Bewegungspunkte);
            
         when TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum'Range =>
            EinheitBefehle (RasseExtern  => RasseExtern,
                            BefehlExtern => Befehl);
            
         when TastenbelegungKonstanten.InfosKonstante =>
            -- Hier mal was reinbauen.
            null;

         when TastenbelegungKonstanten.DiplomatieKonstante =>
            Diplomatie.DiplomatieMöglich (RasseExtern => RasseExtern);

         when TastenbelegungKonstanten.GeheZuKonstante =>
            -- Funktioniert in der SFML nicht richtig. Fehler liegt irgendwo im Grafikteil da die Logik nach wie vor weiterläuft.
            -- Möglicherweise in BerechnungenKarteSFML.SichtbereichKarteBerechnen oder weil die Darstellungsermittlung läuft während BewegungCursor.GeheZuCursor die Werte des Cursors ändert.
            -- Eventuell war es auch die Vermischung der Kartenkoordinatenermittlung in BerechnungenKarteSFML die diesen Fehler ausgelöst hat.
            -- Auf jeden Fall nicht mehr hier einbinden, da sonst wieder die Ermittlung von Logik und Grafik gleichzeitig aufgerufen wird. 
            -- BewegungCursor.GeheZuCursor (RasseExtern => RasseExtern);
            null;

         when TastenbelegungKonstanten.StadtUmbenennenKonstante =>
            StadtUmbenennen (RasseExtern => RasseExtern);
            
         when TastenbelegungKonstanten.StadtAbreißenKonstante =>
            StadtAbreißen (RasseExtern => RasseExtern);
            
         when TastenbelegungKonstanten.StadtSuchenKonstante =>
            StadtSuchenNachNamen := StadtSuchen.StadtNachNamenSuchen;
            
         when TastenbelegungKonstanten.NächsteStadtMeldungKonstante =>
            NaechstesObjekt.NächsteStadtMeldung (RasseExtern => RasseExtern);
            
         when TastenbelegungKonstanten.NächsteEinheitMeldungKonstante =>
            NaechstesObjekt.NächsteEinheitMeldung (RasseExtern => RasseExtern);
            
         when TastenbelegungKonstanten.HeimatstadtÄndernKonstante =>
            EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => (RasseExtern, 0));
            
         when TastenbelegungKonstanten.RundeBeendenTastenbelegungKonstante =>
            return SystemKonstanten.RundeBeendenKonstante;
            
         when TastenbelegungKonstanten.DebugmenüKonstante =>
            DebugPlatzhalter.Menü (RasseExtern => RasseExtern);
            
         when TastenbelegungKonstanten.LeerTastenbelegungKonstante =>
            null;
      end case;
      
      return SystemKonstanten.StartWeiterKonstante;
      
   end BefehleSFML;
   
   
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Koordinaten);
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Koordinaten);

      if
        EinheitNummer /= EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First
        and
          StadtNummer /= EinheitStadtDatentypen.MaximaleStädteMitNullWert'First
      then
         -- Transporter sollten in der Stadt nicht beladen sein, deswegen es hier keine Prüfung auf Transporter braucht.
         EinheitOderStadt (RasseExtern         => RasseExtern,
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);
         
      elsif
        StadtNummer /= EinheitStadtDatentypen.MaximaleStädteMitNullWert'First
      then
         StadtBetreten (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
         
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
         TransporterNummer := EinheitRasseNummerExtern.Platznummer;
         AusgewählteEinheit := 0;

      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerWirdTransportiert
      then
         TransporterNummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         AusgewählteEinheit := AuswahlStadtEinheit.AuswahlStadtEinheit (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                                                         StadtNummerExtern   => EinheitStadtDatentypen.MaximaleStädteMitNullWert'First,
                                                                         EinheitNummerExtern => TransporterNummer);

      else
         TransporterNummer := EinheitRasseNummerExtern.Platznummer;
         AusgewählteEinheit := AuswahlStadtEinheit.AuswahlStadtEinheit (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                                                         StadtNummerExtern   => EinheitStadtDatentypen.MaximaleStädteMitNullWert'First,
                                                                         EinheitNummerExtern => TransporterNummer);
      end if;
      
      case
        AusgewählteEinheit
      is
         when 0 =>
            EinheitSteuern (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, TransporterNummer));
            
         when Positive (EinheitStadtRecords.TransporterArray'First) .. Positive (EinheitStadtRecords.TransporterArray'Last) =>
            EinheitSteuern (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, TransporterNummer),
                                                                                                                            PlatzExtern              => EinheitStadtDatentypen.Transportplätze (AusgewählteEinheit))));
            
         when others =>
            null;
      end case;
      
   end AuswahlEinheitTransporter;



   procedure EinheitOderStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      StadtNummerExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      case
        AuswahlStadtEinheit.AuswahlStadtEinheit (RasseExtern         => RasseExtern,
                                                 StadtNummerExtern   => StadtNummerExtern,
                                                 EinheitNummerExtern => EinheitNummerExtern)
      is
         when 0 =>
            StadtBetreten (StadtRasseNummerExtern => (RasseExtern, StadtNummerExtern));
            
         when 1 =>
            EinheitSteuern (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern));
               
         when others =>
            null;
      end case;
      
   end EinheitOderStadt;
   
   
   
   procedure StadtBetreten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      InDerStadt.InDerStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end StadtBetreten;
   
   
   
   procedure EinheitSteuern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= TastenbelegungKonstanten.LeerTastenbelegungKonstante
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
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Koordinaten);
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
         StadtErfolgreichGebaut := StadtBauen.StadtBauen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
                     
      else
         null;
      end if;
      
   end BaueStadt;
   
   
   
   procedure EinheitBefehle
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum)
   is begin
                     
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Koordinaten);
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
         AufgabeDurchführen := False;
                     
      else
         AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer),
                                                              BefehlExtern             => BefehlExtern);
      end if;
      
   end EinheitBefehle;
   
   
   
   procedure StadtUmbenennen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Koordinaten);
      
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
                                                                 KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Koordinaten);
      case
        StadtNummer
      is
         when StadtKonstanten.LeerNummer =>
            return;
            
         when others =>
            null;
      end case;
         
      -- case
      --    Auswahl.AuswahlJaNein (FrageZeileExtern => 30)
      --  is
      --     when SystemKonstanten.JaKonstante =>
      StadtEntfernen.StadtEntfernen (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
            
      --   when others =>
      --      null;
      --  end case;
      
   end StadtAbreißen;

end BefehleSFML;
