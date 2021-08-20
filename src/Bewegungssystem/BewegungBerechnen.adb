pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitenDatenbank;

with Sichtbarkeit, KennenLernen, BewegungLadenEntladen, StadtSuchen, BewegungPassierbarkeitPruefen, LeseKarten, LeseEinheitenGebaut, SchreibeEinheitenGebaut;

package body BewegungBerechnen is

   procedure BewegungEinheitenBerechnung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin

      -- Immer berücksichtigen dass in BewegungssystemEinheiten.BewegungPrüfen bereits geprüft wird ob der Transporter die Einheit transportieren kann und ein freier Platz vorhanden ist.
      if
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).KannTransportieren
          = GlobaleKonstanten.LeerTransportiertWirdTransportiert
      then
         null;
         
      elsif
        StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                    KoordinatenExtern => NeuePositionExtern) = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         BewegungLadenEntladen.TransporterladungVerschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             NeuePositionExtern       => NeuePositionExtern);

      else
         PlatzZumEntladen := BewegungPassierbarkeitPruefen.InStadtEntladbar (TransporterExtern  => EinheitRasseNummerExtern,
                                                                             NeuePositionExtern => NeuePositionExtern);
         
         case
           PlatzZumEntladen
         is
            when False =>
               return;
               
            when True =>
               BewegungLadenEntladen.TransporterStadtEntladen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                               NeuePositionExtern       => NeuePositionExtern);
         end case;
      end if;

      Welchen_Bonus := StraßeUndFlussPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               NeuePositionExtern       => NeuePositionExtern);

      case
        LeseKarten.Grund (PositionExtern => NeuePositionExtern)
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Gebirge | GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            if
              LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) < 1.00
            then
               -- Hier noch Minus das Maximum einfügen.
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := GlobaleKonstanten.LeerEinheit.Bewegungspunkte;
               return;
               
            else
               BewegungspunkteAbzug := 2.00 - Bewegungsmodifikator (Welchen_Bonus);
            end if;
               
         when others =>
            BewegungspunkteAbzug := 1.00 - Bewegungsmodifikator (Welchen_Bonus);
      end case;

      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               BewegungspunkteExtern    => BewegungspunkteAbzug,
                                               PlusMinusExtern          => False);
      -- Hier nicht return, da Bewegung zwar erfolgreich aber jetzt noch die Rechnungen durchlaufen müssen.

      case
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
            null;
            
         when others =>
            BewegungLadenEntladen.EinheitAusTransporterEntfernen (TransporterExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                                                  LadungExtern      => EinheitRasseNummerExtern.Platznummer);
      end case;
      
      case
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when GlobaleDatentypen.Spieler_KI =>
            null;
            
         when others =>            
            GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Position := NeuePositionExtern;
      end case;      
      
      SchreibeEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        PositionExtern           => NeuePositionExtern);
      Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Prüft nur ob das Feld auf dass sich diese Einheit bewegt bereits von einer anderen Rasse aufgedackt wurde und stellt entsprechend Kontakt her.
      KontaktSchleife:
      for FremdeSichtbarkeitSchleifenwert in GlobaleDatentypen.RassenImSpielArray'Range loop
         
         if
           FremdeSichtbarkeitSchleifenwert = EinheitRasseNummerExtern.Rasse
           or
             GlobaleVariablen.RassenImSpiel (FremdeSichtbarkeitSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
            
         elsif
           LeseKarten.Sichtbar (PositionExtern => NeuePositionExtern,
                                RasseExtern    => FremdeSichtbarkeitSchleifenwert) = True
         then
            KennenLernen.Erstkontakt (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                      FremdeRasseExtern => FremdeSichtbarkeitSchleifenwert);
            
         else
            null;
         end if;
         
      end loop KontaktSchleife;
      
   end BewegungEinheitenBerechnung;



   function StraßeUndFlussPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Bewegungsbonuse_Enum
   is begin

      if
        EinheitenDatenbank.EinheitenListe
          (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).Passierbarkeit (GlobaleDatentypen.Boden) = True
        and
          EinheitenDatenbank.EinheitenListe
            (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).Passierbarkeit (GlobaleDatentypen.Luft) = False
        and
          EinheitenDatenbank.EinheitenListe
            (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).Passierbarkeit (GlobaleDatentypen.Weltraum) = False
      then
         case
           LeseKarten.VerbesserungWeg (PositionExtern => NeuePositionExtern)
         is
            when GlobaleDatentypen.Karten_Verbesserung_Weg_Enum'Range =>
               return Straße_Fluss;
                  
            when others =>
               null;
         end case;

         case
           LeseKarten.Fluss (PositionExtern => NeuePositionExtern)
         is
            when GlobaleDatentypen.Leer =>
               null;

            when others =>
               return Straße_Fluss;
         end case;

      else
         null;
      end if;      
      
      return Leer;
      
   end StraßeUndFlussPrüfen;

end BewegungBerechnen;
