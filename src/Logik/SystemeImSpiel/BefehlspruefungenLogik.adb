with AufgabenDatentypen;
with TextnummernKonstanten;
with AuswahlKonstanten;

with LeseEinheitenGebaut;
with LeseCursor;

with StadtmenueLogik;
with AufgabenLogik;
with StadtBauenLogik;
with EinheitSuchenLogik;
with StadtSuchenLogik;
with StadtEntfernenLogik;
with TransporterSuchenLogik;
with AufgabeFestlegenLogik;
with EinheitenkontrollsystemLogik;
with AuswahlStadtEinheitLogik;
with NachGrafiktask;
with JaNeinLogik;
with EinheitenSpielmeldungenLogik;
with StadtAllgemeinesLogik;

-- Hier auch mal überarbeiten, vor allem die Prozeduren weiter unten. äöü
package body BefehlspruefungenLogik is
   
   procedure WasWirdEntfernt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                              KoordinatenExtern => LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern),
                                                                              LogikGrafikExtern => True);
      StadtNummer := StadtSuchenLogik.KoordinatenStadtMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                        KoordinatenExtern => LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern));
      
      if
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
        and
          StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         -- Transporter sollten in der Stadt nicht beladen sein, deswegen es hier keine Prüfung auf Transporter braucht.
         case
           AuswahlStadtEinheitLogik.AuswahlStadtEinheit (SpeziesExtern       => SpeziesExtern,
                                                         StadtNummerExtern   => StadtNummer,
                                                         EinheitNummerExtern => EinheitNummer)
         is
            when AuswahlKonstanten.LeerAuswahl =>
               LeerRückgabewert := StadtEntfernenLogik.StadtAbreißen (StadtSpeziesNummerExtern => (SpeziesExtern, StadtNummer));
               
            when 1 =>
               EinheitBefehle (SpeziesExtern => SpeziesExtern,
                               BefehlExtern  => BefehleDatentypen.Auflösen_Enum);
               
            when others =>
               null;
         end case;
         
      elsif
        StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         LeerRückgabewert := StadtEntfernenLogik.StadtAbreißen (StadtSpeziesNummerExtern => (SpeziesExtern, StadtNummer));
         
      elsif
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
      then
         EinheitBefehle (SpeziesExtern => SpeziesExtern,
                         BefehlExtern  => BefehleDatentypen.Auflösen_Enum);
               
      else
         null;
      end if;
      
   end WasWirdEntfernt;
   
   
   
   procedure AuswahlEinheitStadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                              KoordinatenExtern => LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern),
                                                                              LogikGrafikExtern => True);
      
      StadtNummer := StadtSuchenLogik.KoordinatenStadtMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                        KoordinatenExtern => LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern));

      if
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
        and
          StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         -- Transporter sollten in der Stadt nicht beladen sein, deswegen es hier keine Prüfung auf Transporter braucht.
         EinheitOderStadt (SpeziesExtern       => SpeziesExtern,
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);
         
      elsif
        StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         StadtAktion (StadtSpeziesNummerExtern => (SpeziesExtern, StadtNummer));
         
      elsif
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
      then
         AuswahlEinheitTransporter (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummer));
               
      else
         null;
      end if;
      
   end AuswahlEinheitStadt;
   
   
   
   procedure AuswahlEinheitTransporter
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      Transportiert := TransporterSuchenLogik.HatTransporterLadung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      if
        LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerWirdTransportiert
        and
          Transportiert = False
      then
         TransporterNummer := EinheitSpeziesNummerExtern.Nummer;
         AusgewählteEinheit := AuswahlKonstanten.LeerAuswahl;

      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) /= EinheitenKonstanten.LeerWirdTransportiert
      then
         TransporterNummer := LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         AusgewählteEinheit := AuswahlStadtEinheitLogik.AuswahlStadtEinheit (SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies,
                                                                              StadtNummerExtern   => StadtDatentypen.MaximaleStädteMitNullWert'First,
                                                                              EinheitNummerExtern => TransporterNummer);

      else
         TransporterNummer := EinheitSpeziesNummerExtern.Nummer;
         AusgewählteEinheit := AuswahlStadtEinheitLogik.AuswahlStadtEinheit (SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies,
                                                                              StadtNummerExtern   => StadtDatentypen.MaximaleStädteMitNullWert'First,
                                                                              EinheitNummerExtern => TransporterNummer);
      end if;
      
      case
        AusgewählteEinheit
      is
         when AuswahlKonstanten.LeerAuswahl =>
            EinheitSteuern (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, TransporterNummer));
            
         when Positive (EinheitenRecords.TransporterArray'First) .. Positive (EinheitenRecords.TransporterArray'Last) =>
            EinheitSteuern (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, TransporterNummer),
                                                                                                                                  PlatzExtern                => EinheitenDatentypen.Transportplätze (AusgewählteEinheit))));
            
         when others =>
            null;
      end case;
      
   end AuswahlEinheitTransporter;



   procedure EinheitOderStadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      case
        AuswahlStadtEinheitLogik.AuswahlStadtEinheit (SpeziesExtern       => SpeziesExtern,
                                                      StadtNummerExtern   => StadtNummerExtern,
                                                      EinheitNummerExtern => EinheitNummerExtern)
      is
         when AuswahlKonstanten.LeerAuswahl =>
            StadtAktion (StadtSpeziesNummerExtern => (SpeziesExtern, StadtNummerExtern));
            
         when 1 =>
            EinheitSteuern (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerExtern));
               
         when others =>
            null;
      end case;
      
   end EinheitOderStadt;
   
   
   
   procedure EinheitSteuern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.Bewegungspunkte;
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
      
      NachGrafiktask.AktuelleEinheit := EinheitSpeziesNummerExtern.Nummer;
      
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
      then
         case
           EinheitenSpielmeldungenLogik.BewegungspunkteMeldung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
         is
            when True =>
               EinheitenkontrollsystemLogik.Einheitenkontrolle (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               
            when False =>
               null;
         end case;
            
      else
         case
           JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageBeschäftigungAbbrechen)
         is
            when True =>
               AufgabeFestlegenLogik.Nullsetzung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               
               if
                 LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerBewegungspunkte
               then
                  null;
                  
               else
                  EinheitenkontrollsystemLogik.Einheitenkontrolle (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               end if;
               
            when others =>
               null;
         end case;
      end if;
      
      NachGrafiktask.AktuelleEinheit := EinheitenKonstanten.LeerNummer;
            
   end EinheitSteuern;
   
   
   
   procedure BaueStadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                              KoordinatenExtern => LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern),
                                                                              LogikGrafikExtern => True);
      case
        EinheitNummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        EinheitenSpielmeldungenLogik.BewegungspunkteMeldung (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummer))
      is
         when True =>
            LeerRückgabewert := StadtBauenLogik.StadtBauen (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummer));
            
         when False =>
            null;
      end case;
      
   end BaueStadt;
   
   
   
   procedure EinheitBefehle
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Klein_Enum)
   is begin
                     
      EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                              KoordinatenExtern => LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern),
                                                                              LogikGrafikExtern => True);
      
      case
        EinheitNummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
                  
         when others =>
            null;
      end case;
      
      case
        EinheitenSpielmeldungenLogik.BewegungspunkteMeldung (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummer))
      is
         when True =>
            LeerRückgabewert := AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummer),
                                                        BefehlExtern               => BefehlExtern,
                                                        AnlegenTestenExtern        => True,
                                                        KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummer)));
            
         when False =>
            null;
      end case;
      
   end EinheitBefehle;
   
   
   
   procedure StadtUmbenennen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      StadtNummer := StadtSuchenLogik.KoordinatenStadtMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                        KoordinatenExtern => LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern));
      
      case
        StadtNummer
      is
         when StadtKonstanten.LeerNummer =>
            null;
         
         when others =>
            StadtAllgemeinesLogik.NeuerStadtname (StadtSpeziesNummerExtern => (SpeziesExtern, StadtNummer));
      end case;
      
   end StadtUmbenennen;
   
   
   
   -- Hier dann später die Prüfungen für das vorhandene Stadtbewegungsgebäude und die entsprechende Auswahl zwischen Stadt betreten und bewegen einbauen. äöü
   procedure StadtAktion
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      
      
      StadtmenueLogik.Stadtmenü (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
   end StadtAktion;

end BefehlspruefungenLogik;
