pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with RueckgabeDatentypen; use RueckgabeDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;
with TextnummernKonstanten;

with SchreibeStadtGebaut;
with LeseEinheitenGebaut;

with InDerStadt;
with BewegungCursor;
with NaechstesObjekt;
with Aufgaben;
with Diplomatie;
with DebugmenueSFML;
with StadtBauen;
with EinheitSuchen;
with StadtSuchen;
with EingabeSFML;
with ForschungAllgemein;
with StadtEntfernen;
with TransporterSuchen;
with EinheitenModifizieren;
with AufgabenAllgemein;
with BewegungEinheitenSFML;
with AuswahlStadtEinheit;
with NachGrafiktask;
with AuswahlSFML;

-- Hier auch mal überarbeiten, vor allem die Prozeduren weiter unten. äöü
package body BefehleSFML is
   
   -- Kann man nicht auch hier eine Schleife einbauen und sich das Zurückgehen sparen? äöü
   function Befehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
                               
      Befehl := EingabeSFML.Tastenwert;

      case
        Befehl
      is
         -- Die folgenden Befehl ist so sinnfrei, entweder ganz entfernen oder anpassen wie GeheZu. äöü
         when TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum'Range =>
            null;
            -- BewegungCursor.CursorbewegungBerechnen (RichtungExtern => Befehl,
            --                                         RasseExtern    => RasseExtern);
            
         when TastenbelegungDatentypen.Auswählen_Enum =>
            AuswahlEinheitStadt (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Menü_Zurück_Enum =>
            return RueckgabeDatentypen.Spielmenü_Enum;

         when TastenbelegungDatentypen.Bauen_Enum =>
            BaueStadt (RasseExtern => RasseExtern);
           
         when TastenbelegungDatentypen.Forschung_Enum =>
            ForschungAllgemein.Forschung (RasseExtern => RasseExtern);
            
            -- Die folgenden vier Befehle scheinen gar nicht mehr zu funktionieren. äöü
            -- So anpassen wie GeheZu. äöü
         when TastenbelegungDatentypen.Nächste_Stadt_Enum =>
            NaechstesObjekt.NächsteStadt (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Hat_Bewegungspunkte);
            
         when TastenbelegungDatentypen.Alle_Einheiten_Enum =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Egal_Bewegeungspunkte);
            
         when TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Keine_Bewegungspunkte);
            
         when TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum'Range =>
            if
              Befehl = TastenbelegungDatentypen.Auflösen_Enum
            then
               WasWirdEntfernt (RasseExtern => RasseExtern);
               
            else
               EinheitBefehle (RasseExtern  => RasseExtern,
                               BefehlExtern => Befehl);
            end if;

         when TastenbelegungDatentypen.Diplomatie_Enum =>
            Diplomatie.DiplomatieMöglich (RasseExtern => RasseExtern);

         when TastenbelegungDatentypen.Gehe_Zu_Enum =>
            BewegungCursor.GeheZu;

         when TastenbelegungDatentypen.Stadt_Umbenennen_Enum =>
            StadtUmbenennen (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Stadt_Suchen_Enum =>
            StadtSuchenNachNamen := StadtSuchen.StadtNachNamenSuchen;
            
         when TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum =>
            NaechstesObjekt.NächsteStadtMeldung (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum =>
            NaechstesObjekt.NächsteEinheitMeldung (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Heimatstadt_Ändern_Enum =>
            EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => (RasseExtern, 0));
            
         when TastenbelegungDatentypen.Runde_Beenden_Enum =>
            return RueckgabeDatentypen.Runde_Beenden_Enum;
            
         when TastenbelegungDatentypen.Debugmenü_Enum =>
            DebugmenueSFML.Debugmenü (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Leer_Tastenbelegung_Enum =>
            null;
      end case;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end Befehle;
   
   
   
   -- Irgendwas scheint hier noch nicht richtig zu funktionieren? äöü
   procedure WasWirdEntfernt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      if
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
        and
          StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         -- Transporter sollten in der Stadt nicht beladen sein, deswegen es hier keine Prüfung auf Transporter braucht.
         case
           AuswahlStadtEinheit.AuswahlStadtEinheit (RasseExtern         => RasseExtern,
                                                    StadtNummerExtern   => StadtNummer,
                                                    EinheitNummerExtern => EinheitNummer)
         is
            when 0 =>
               StadtEntfernen.StadtAbreißen (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
            
            when 1 =>
               EinheitBefehle (RasseExtern  => RasseExtern,
                               BefehlExtern => TastenbelegungDatentypen.Auflösen_Enum);
               
            when others =>
               null;
         end case;
         
      elsif
        StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         StadtEntfernen.StadtAbreißen (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
         
      elsif
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
      then
         EinheitBefehle (RasseExtern  => RasseExtern,
                         BefehlExtern => TastenbelegungDatentypen.Auflösen_Enum);
               
      else
         null;
      end if;
      
   end WasWirdEntfernt;
   
   
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);

      if
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
        and
          StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         -- Transporter sollten in der Stadt nicht beladen sein, deswegen es hier keine Prüfung auf Transporter braucht.
         EinheitOderStadt (RasseExtern         => RasseExtern,
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);
         
      elsif
        StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         InDerStadt.InDerStadt (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
         
      elsif
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
      then
         AuswahlEinheitTransporter (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
               
      else
         null;
      end if;
      
   end AuswahlEinheitStadt;
   
   
   
   procedure AuswahlEinheitTransporter
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Transportiert := TransporterSuchen.HatTransporterLadung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerWirdTransportiert
        and
          Transportiert = False
      then
         TransporterNummer := EinheitRasseNummerExtern.Nummer;
         AusgewählteEinheit := 0;

      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerWirdTransportiert
      then
         TransporterNummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         AusgewählteEinheit := AuswahlStadtEinheit.AuswahlStadtEinheit (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                                                         StadtNummerExtern   => StadtDatentypen.MaximaleStädteMitNullWert'First,
                                                                         EinheitNummerExtern => TransporterNummer);

      else
         TransporterNummer := EinheitRasseNummerExtern.Nummer;
         AusgewählteEinheit := AuswahlStadtEinheit.AuswahlStadtEinheit (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                                                         StadtNummerExtern   => StadtDatentypen.MaximaleStädteMitNullWert'First,
                                                                         EinheitNummerExtern => TransporterNummer);
      end if;
      
      case
        AusgewählteEinheit
      is
         when 0 =>
            EinheitSteuern (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, TransporterNummer));
            
         when Positive (EinheitenRecords.TransporterArray'First) .. Positive (EinheitenRecords.TransporterArray'Last) =>
            EinheitSteuern (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, TransporterNummer),
                                                                                                                            PlatzExtern              => EinheitenDatentypen.Transportplätze (AusgewählteEinheit))));
            
         when others =>
            null;
      end case;
      
   end AuswahlEinheitTransporter;



   procedure EinheitOderStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      case
        AuswahlStadtEinheit.AuswahlStadtEinheit (RasseExtern         => RasseExtern,
                                                 StadtNummerExtern   => StadtNummerExtern,
                                                 EinheitNummerExtern => EinheitNummerExtern)
      is
         when 0 =>
            InDerStadt.InDerStadt (StadtRasseNummerExtern => (RasseExtern, StadtNummerExtern));
            
         when 1 =>
            EinheitSteuern (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern));
               
         when others =>
            null;
      end case;
      
   end EinheitOderStadt;
   
   
   
   procedure EinheitSteuern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      NachGrafiktask.AktuelleEinheit := EinheitRasseNummerExtern.Nummer;
      
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
        and then
          AuswahlSFML.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageBeschäftigungAbbrechen) = True
      then
         AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         BewegungEinheitenSFML.BewegungEinheitenRichtung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBewegungspunkte
      then
         null;
         
      else
         BewegungEinheitenSFML.BewegungEinheitenRichtung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
      NachGrafiktask.AktuelleEinheit := EinheitenKonstanten.LeerNummer;
      
   end EinheitSteuern;
   
   
   
   procedure BaueStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      case
        EinheitNummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer)) > EinheitenKonstanten.LeerBewegungspunkte
      then
         StadtErfolgreichGebaut := StadtBauen.StadtBauen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
                     
      else
         null;
      end if;
      
   end BaueStadt;
   
   
   
   procedure EinheitBefehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum)
   is begin
                     
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      if
        EinheitNummer = EinheitenKonstanten.LeerNummer
      then
         return;
                  
      else
         null;
      end if;
            
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer)) = EinheitenKonstanten.LeerBewegungspunkte
      then
         AufgabeDurchführen := False;
                     
      else
         AufgabeDurchführen := Aufgaben.Aufgabe (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer),
                                                  BefehlExtern             => BefehlExtern,
                                                  KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer)));
      end if;
      
   end EinheitBefehle;
   
   
   
   procedure StadtUmbenennen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- StadtSuchen mal überall das neue Speichersystem anpassen. äöü
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      if
        StadtNummer = StadtKonstanten.LeerNummer
      then
         null;
         
      else
         NeuerName := EingabeSFML.StadtName;
         
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

end BefehleSFML;
