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
with LeseWichtiges;

with InDerStadt;
with BewegungEinheitenKonsole;
with BewegungCursor;
with Auswahl;
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
with EinheitenTransporter;
with TransporterSuchen;
with EinheitenBeschreibungen;
with EinheitenModifizieren;
with AufgabenAllgemein;
with ForschungAnzeigeKonsole;

package body BefehleKonsole is

   function BefehleKonsole
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
            Technologie (RasseExtern => RasseExtern);
            
         when TastenbelegungKonstanten.TechBaumKonstante =>
            -- Kann in der SMFL Version ignoriert werden oder das auch in der Konsolenversion ändern und den Befehl komplett wegwerfen?
            -- Muss bei reiner Anzeige dann auf jeden Fall auch in den Grafikteil.
            ForschungAnzeigeKonsole.ForschungsBaum (RasseExtern => RasseExtern);
            
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
            BewegungCursor.GeheZuCursor (RasseExtern => RasseExtern);

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
      
   end BefehleKonsole;
   
   
   
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
      
      GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse := 1;
      GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse := 1;
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
         BewegungEinheitenKonsole.BewegungEinheitenRichtung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
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
         
      case
        Auswahl.AuswahlJaNein (FrageZeileExtern => 30)
      is
         when SystemKonstanten.JaKonstante =>
            StadtEntfernen.StadtEntfernen (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
            
         when others =>
            null;
      end case;
      
   end StadtAbreißen;

end BefehleKonsole;
