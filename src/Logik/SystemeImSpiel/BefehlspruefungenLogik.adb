pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with StadtDatentypen; use StadtDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;
with TextnummernKonstanten;

with LeseEinheitenGebaut;

with StadtmenueLogik;
with AufgabenLogik;
with StadtBauen;
with EinheitSuchen;
with StadtSuchen;
with StadtEntfernen;
with TransporterSuchenLogik;
with AufgabenAllgemeinLogik;
with EinheitenkontrollsystemLogik;
with AuswahlStadtEinheitLogik;
with NachGrafiktask;
with JaNeinLogik;
with EinheitenSpielmeldungenLogik;
with StadtAllgemeinLogik;

-- Hier auch mal überarbeiten, vor allem die Prozeduren weiter unten. äöü
package body BefehlspruefungenLogik is
   
   procedure WasWirdEntfernt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                       LogikGrafikExtern => True);
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      if
        EinheitNummer /= EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
        and
          StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         -- Transporter sollten in der Stadt nicht beladen sein, deswegen es hier keine Prüfung auf Transporter braucht.
         case
           AuswahlStadtEinheitLogik.AuswahlStadtEinheit (RasseExtern         => RasseExtern,
                                                         StadtNummerExtern   => StadtNummer,
                                                         EinheitNummerExtern => EinheitNummer)
         is
            when 0 =>
               LeerRückgabewert := StadtEntfernen.StadtAbreißen (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
               
            when 1 =>
               EinheitBefehle (RasseExtern  => RasseExtern,
                               BefehlExtern => TastenbelegungDatentypen.Auflösen_Enum);
               
            when others =>
               null;
         end case;
         
      elsif
        StadtNummer /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         LeerRückgabewert := StadtEntfernen.StadtAbreißen (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
         
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
                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                       LogikGrafikExtern => True);
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
         StadtmenueLogik.Stadtmenü (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
         
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
      
      Transportiert := TransporterSuchenLogik.HatTransporterLadung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
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
         AusgewählteEinheit := AuswahlStadtEinheitLogik.AuswahlStadtEinheit (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                                                              StadtNummerExtern   => StadtDatentypen.MaximaleStädteMitNullWert'First,
                                                                              EinheitNummerExtern => TransporterNummer);

      else
         TransporterNummer := EinheitRasseNummerExtern.Nummer;
         AusgewählteEinheit := AuswahlStadtEinheitLogik.AuswahlStadtEinheit (RasseExtern         => EinheitRasseNummerExtern.Rasse,
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
        AuswahlStadtEinheitLogik.AuswahlStadtEinheit (RasseExtern         => RasseExtern,
                                                      StadtNummerExtern   => StadtNummerExtern,
                                                      EinheitNummerExtern => EinheitNummerExtern)
      is
         when 0 =>
            StadtmenueLogik.Stadtmenü (StadtRasseNummerExtern => (RasseExtern, StadtNummerExtern));
            
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
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
      then
         case
           EinheitenSpielmeldungenLogik.BewegungspunkteMeldung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               EinheitenkontrollsystemLogik.Einheitenkontrolle (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
            when False =>
               null;
         end case;
            
      else
         case
           JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageBeschäftigungAbbrechen)
         is
            when True =>
               AufgabenAllgemeinLogik.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
               if
                 LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBewegungspunkte
               then
                  null;
                  
               else
                  EinheitenkontrollsystemLogik.Einheitenkontrolle (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               end if;
               
            when others =>
               null;
         end case;
      end if;
      
      NachGrafiktask.AktuelleEinheit := EinheitenKonstanten.LeerNummer;
            
   end EinheitSteuern;
   
   
   
   procedure BaueStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
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
        EinheitenSpielmeldungenLogik.BewegungspunkteMeldung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer))
      is
         when True =>
            LeerRückgabewert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer));
            
         when False =>
            null;
      end case;
      
   end BaueStadt;
   
   
   
   procedure EinheitBefehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum)
   is begin
                     
      EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
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
        EinheitenSpielmeldungenLogik.BewegungspunkteMeldung (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer))
      is
         when True =>
            LeerRückgabewert := AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer),
                                                        BefehlExtern             => BefehlExtern,
                                                        KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitNummer)));
            
         when False =>
            null;
      end case;
      
   end EinheitBefehle;
   
   
   
   -- Das hier ins Stadtsystem verschieben oder mit dem bereits vorhandenen Zeug zusammenführen. äöü
   procedure StadtUmbenennen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                 KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      case
        StadtNummer
      is
         when StadtKonstanten.LeerNummer =>
            null;
         
         when others =>
            StadtAllgemeinLogik.NeuerStadtname (StadtRasseNummerExtern => (RasseExtern, StadtNummer));
      end case;
      
   end StadtUmbenennen;

end BefehlspruefungenLogik;
