pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitenDatenbank;

with Sichtbarkeit, KennenLernen, BewegungLadenEntladen, StadtSuchen, BewegungPassierbarkeitPruefen;

package body BewegungBerechnen is

   procedure BewegungEinheitenBerechnung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin

      -- Immer berücksichtigen dass in BewegungssystemEinheiten.BewegungPrüfen bereits geprüft wird ob der Transporter die Einheit transportieren kann und ein freier Platz vorhanden ist.
      if
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).KannTransportieren
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
        Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).Grund
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Gebirge | GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte < 1.00
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := GlobaleKonstanten.LeerEinheit.Bewegungspunkte;
               return;
               
            else                     
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte - 2.00 + Bewegungsmodifikator (Welchen_Bonus);
            end if;
               
         when others =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte
              := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte - 1.00 + Bewegungsmodifikator (Welchen_Bonus);
      end case;

      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte < GlobaleKonstanten.LeerEinheit.Bewegungspunkte
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := GlobaleKonstanten.LeerEinheit.Bewegungspunkte;
         -- Hier nicht return, da Bewegung zwar erfolgreich aber jetzt noch die Rechnungen durchlaufen müssen.
                  
      else
         null;
      end if;

      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert
      is
         when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
            null;
            
         when others =>
            BewegungLadenEntladen.EinheitAusTransporterEntfernen (TransporterExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert),
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
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position := NeuePositionExtern;
      Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Funktioniert doch gar nicht richtig, oder?
      KontaktSchleife:
      for FremdeSichtbarkeitSchleifenwert in GlobaleDatentypen.RassenImSpielArray'Range loop
         
         if
           FremdeSichtbarkeitSchleifenwert = EinheitRasseNummerExtern.Rasse
           or
             GlobaleVariablen.RassenImSpiel (FremdeSichtbarkeitSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
            
         elsif
           Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).Sichtbar (FremdeSichtbarkeitSchleifenwert) = True
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
          (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (GlobaleDatentypen.Boden) = True
        and
          EinheitenDatenbank.EinheitenListe
            (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (GlobaleDatentypen.Luft) = False
        and
          EinheitenDatenbank.EinheitenListe
            (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (GlobaleDatentypen.Weltraum) = False
      then
         case
           Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungStraße
         is
            when GlobaleDatentypen.Karten_Verbesserung_Straße_Enum'Range =>
               return Straße_Fluss;
                  
            when others =>
               null;
         end case;

         case
           Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).Fluss
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
