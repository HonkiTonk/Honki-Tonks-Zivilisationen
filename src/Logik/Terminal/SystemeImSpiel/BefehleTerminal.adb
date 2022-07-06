pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with RueckgabeDatentypen; use RueckgabeDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;
with TextKonstanten;
with ForschungenDatentypen;

with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseWichtiges;

with InDerStadt;
with BewegungEinheitenTerminal;
with BewegungCursor;
with Auswahl;
with NaechstesObjekt;
with Aufgaben;
with Diplomatie;
with DebugmenueTerminal;
with StadtBauen;
with EinheitSuchen;
with StadtSuchen;
with Eingabe;
with ForschungAllgemein;
with StadtEntfernen;
with EinheitenTransporterAuswahlTerminal;
with TransporterSuchen;
with EinheitenModifizieren;
with AufgabenAllgemein;
with ForschungAnzeigeTerminal;

package body BefehleTerminal is

   function Befehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      Befehl := Eingabe.Tastenwert;

      case
        Befehl
      is
         when TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum'Range =>
            BewegungCursor.BewegungCursorRichtung (KarteExtern    => True,
                                                   RichtungExtern => Befehl,
                                                   RasseExtern    => RasseExtern);
            
         when TastenbelegungDatentypen.Auswählen_Enum =>
            AuswahlEinheitStadt (RasseExtern => RasseExtern);
                 
         when TastenbelegungDatentypen.Menü_Zurück_Enum =>
            return RueckgabeDatentypen.Spielmenü_Enum;

         when TastenbelegungDatentypen.Bauen_Enum =>
            BaueStadt (RasseExtern => RasseExtern);
           
         when TastenbelegungDatentypen.Forschung_Enum =>
            Technologie (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Tech_Baum_Enum =>
            -- Kann in der SMFL Version ignoriert werden oder das auch in der Terminalnversion ändern und den Befehl komplett wegwerfen?
            -- Muss bei reiner Anzeige dann auf jeden Fall auch in den Grafikteil.
            ForschungAnzeigeTerminal.ForschungsBaum (RasseExtern => RasseExtern);
            
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
            EinheitBefehle (RasseExtern  => RasseExtern,
                            BefehlExtern => Befehl);
            
         when TastenbelegungDatentypen.Infos_Enum =>
            -- Hier mal was reinbauen.
            null;

         when TastenbelegungDatentypen.Diplomatie_Enum =>
            Diplomatie.DiplomatieMöglich (RasseExtern => RasseExtern);

         when TastenbelegungDatentypen.Gehe_Zu_Enum =>
            BewegungCursor.GeheZuCursor (RasseExtern => RasseExtern);

         when TastenbelegungDatentypen.Stadt_Umbenennen_Enum =>
            StadtUmbenennen (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Stadt_Abreißen_Enum =>
            StadtAbreißen (RasseExtern => RasseExtern);
            
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
            DebugmenueTerminal.Menü (RasseExtern => RasseExtern);
         
         when TastenbelegungDatentypen.Leer_Tastenbelegung_Enum =>
            null;
      end case;

      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end Befehle;
   
   
   
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
         EinheitOderStadt (RasseExtern         => RasseExtern,
                           AuswahlExtern       => Auswahl.AuswahlJaNein (FrageZeileExtern => TextKonstanten.FrageStadtBetreten),
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);
         
      elsif
        StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         EinheitOderStadt (RasseExtern         => RasseExtern,
                           AuswahlExtern       => True,
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);
         
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
         EinheitTransportNummer := EinheitRasseNummerExtern.Nummer;

      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerWirdTransportiert
      then
         EinheitTransportNummer := EinheitenTransporterAuswahlTerminal.EinheitTransporterAuswählen
             (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));

      else
         EinheitTransportNummer := EinheitenTransporterAuswahlTerminal.EinheitTransporterAuswählen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
      case
        EinheitTransportNummer
      is
         when EinheitenKonstanten.LeerNummer =>
            null;
                        
         when others =>
            EinheitOderStadt (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                              AuswahlExtern       => False,
                              StadtNummerExtern   => StadtDatentypen.MaximaleStädteMitNullWert'First,
                              EinheitNummerExtern => EinheitTransportNummer);
      end case;
      
   end AuswahlEinheitTransporter;



   procedure EinheitOderStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AuswahlExtern : in Boolean;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      case
        AuswahlExtern
      is
         when True =>
            StadtBetreten (StadtRasseNummerExtern => (RasseExtern, StadtNummerExtern));
            
         when False =>
            EinheitSteuern (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern));
      end case;
      
   end EinheitOderStadt;
   
   
   
   procedure StadtBetreten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse := 1;
      SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse := 1;
      InDerStadt.InDerStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end StadtBetreten;
   
   
   
   procedure EinheitSteuern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
        and then
        Auswahl.AuswahlJaNein (FrageZeileExtern => TextKonstanten.FrageBeschäftigungAbbrechen) = True
      then
         AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  
      elsif
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBewegungspunkte
      then
         null;
                     
      else
         BewegungEinheitenTerminal.BewegungEinheitenRichtung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
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
         NullWert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
                     
      else
         null;
      end if;
      
   end BaueStadt;
   
   
   
   procedure Technologie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern)
      is
         when ForschungenDatentypen.ForschungIDMitNullWert'First =>
            ForschungAllgemein.Forschung (RasseExtern => RasseExtern);
            return;
            
         when others =>
            null;
      end case;
                    
      case
        Auswahl.AuswahlJaNein (FrageZeileExtern => TextKonstanten.FrageForschungAbbrechen)
      is
         when True =>
            ForschungAllgemein.Forschung (RasseExtern => RasseExtern);
                     
         when False =>
            null;
      end case;
      
   end Technologie;
   
   
   
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
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
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
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      case
        StadtNummer
      is
         when StadtKonstanten.LeerNummer =>
            return;
            
         when others =>
            null;
      end case;
         
      case
        Auswahl.AuswahlJaNein (FrageZeileExtern => TextKonstanten.FrageStadtAbreißen)
      is
         when True =>
            StadtEntfernen.StadtEntfernen (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
            
         when False =>
            null;
      end case;
      
   end StadtAbreißen;

end BefehleTerminal;
