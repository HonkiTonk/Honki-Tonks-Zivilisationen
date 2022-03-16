pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;
with KartenGrundDatentypen;
with KartenVerbesserungDatentypen;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with Sichtbarkeit;
with KennenLernen;
with BewegungLadenEntladen;
with StadtSuchen;
with BewegungPassierbarkeitPruefen;

package body BewegungBerechnen is

   procedure BewegungEinheitenBerechnung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin

      -- Immer berücksichtigen dass in BewegungssystemEinheiten.BewegungPrüfen bereits geprüft wird ob der Transporter die Einheit transportieren kann und ein freier Platz vorhanden ist.
      if
        LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
          = EinheitenKonstanten.LeerKannTransportieren
      then
         null;
         
      elsif
        StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                    KoordinatenExtern => NeueKoordinatenExtern)
        = EinheitenKonstanten.LeerNummer
      then
         BewegungLadenEntladen.TransporterladungVerschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             NeueKoordinatenExtern    => NeueKoordinatenExtern);

      else
         case
           BewegungPassierbarkeitPruefen.InStadtEntladbar (TransporterExtern     => EinheitRasseNummerExtern,
                                                           NeueKoordinatenExtern => NeueKoordinatenExtern)
         is
            when False =>
               return;
               
            when True =>
               BewegungLadenEntladen.TransporterStadtEntladen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                               NeueKoordinatenExtern    => NeueKoordinatenExtern);
         end case;
      end if;

      BewegungspunkteAbzug := AbzugDurchBewegung (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                                                  EinheitRasseNummerExtern => EinheitRasseNummerExtern);
        
      if
        BewegungspunkteAbzug = EinheitUnbewegbar
      then
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => EinheitenKonstanten.LeerEinheit.Bewegungspunkte,
                                                  RechnenSetzenExtern      => 0);
         return;
         
      else
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => BewegungspunkteAbzug,
                                                  RechnenSetzenExtern      => -1);
      end if;
      -- Hier nicht return, da Bewegung zwar erfolgreich aber jetzt noch die Rechnungen durchlaufen müssen.

      case
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            null;
            
         when others =>
            BewegungLadenEntladen.EinheitAusTransporterEntfernen (TransporterExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                                                  LadungExtern      => EinheitRasseNummerExtern.Platznummer);
      end case;
      
      case
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when SystemDatentypen.Spieler_KI_Enum =>
            null;
            
         when others =>
            GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAktuell := NeueKoordinatenExtern;
      end case;
      
      SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           KoordinatenExtern        => NeueKoordinatenExtern);
      NachBewegung (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                    EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end BewegungEinheitenBerechnung;
   
   
   
   procedure NachBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Prüft nur ob das Feld auf dass sich diese Einheit bewegt bereits von einer anderen Rasse aufgedeckt wurde und stellt entsprechend Kontakt her.
      KontaktSchleife:
      for FremdeSichtbarkeitSchleifenwert in SystemDatentypen.RassenImSpielArray'Range loop
         
         if
           FremdeSichtbarkeitSchleifenwert = EinheitRasseNummerExtern.Rasse
           or
             GlobaleVariablen.RassenImSpiel (FremdeSichtbarkeitSchleifenwert) = SystemDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           LeseKarten.Sichtbar (KoordinatenExtern => NeueKoordinatenExtern,
                                RasseExtern       => FremdeSichtbarkeitSchleifenwert)
           = True
         then
            KennenLernen.Erstkontakt (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                      FremdeRasseExtern => FremdeSichtbarkeitSchleifenwert);
            
         else
            null;
         end if;
         
      end loop KontaktSchleife;
      
   end NachBewegung;
   
      
   
   function AbzugDurchBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
         return EinheitStadtDatentypen.BewegungFloat
   is begin
      
      Welchen_Bonus := StraßeUndFlussPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               NeueKoordinatenExtern    => NeueKoordinatenExtern);

      case
        LeseKarten.Grund (KoordinatenExtern => NeueKoordinatenExtern)
      is
         when KartenGrundDatentypen.Eis_Enum | KartenGrundDatentypen.Gebirge_Enum | KartenGrundDatentypen.Dschungel_Enum | KartenGrundDatentypen.Sumpf_Enum =>
            if
              LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) < KleinerAbzug
            then
               return EinheitUnbewegbar;
      
            elsif
              MittlererAbzug - Bewegungsmodifikator (Welchen_Bonus) <= KeinAbzug
            then
               return KeinAbzug;
               
            else
               return MittlererAbzug - Bewegungsmodifikator (Welchen_Bonus);
            end if;
            
         when others =>
            if
              KleinerAbzug - Bewegungsmodifikator (Welchen_Bonus) <= KeinAbzug
            then
               return KeinAbzug;
            
            else
               return KleinerAbzug - Bewegungsmodifikator (Welchen_Bonus);
            end if;
      end case;
      
   end AbzugDurchBewegung;

   

   function StraßeUndFlussPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Bewegungsbonuse_Enum
   is begin

      if
        LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                               IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               WelcheUmgebungExtern => EinheitStadtDatentypen.Luft_Enum)
        = False
        and
          LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                 IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                 WelcheUmgebungExtern => EinheitStadtDatentypen.Weltraum_Enum)
        = False
      then
         case
           LeseKarten.VerbesserungWeg (KoordinatenExtern => NeueKoordinatenExtern)
         is
            when KartenVerbesserungDatentypen.Karten_Verbesserung_Weg_Enum'Range =>
               return Straße_Fluss_Enum;
               
            when KartenVerbesserungDatentypen.Karten_Verbesserung_Schiene_Enum'Range =>
               return Schiene_Enum;
               
            when KartenVerbesserungDatentypen.Karten_Verbesserung_Tunnel_Enum =>
               return Straße_Fluss_Enum;
                  
            when others =>
               null;
         end case;

         case
           LeseKarten.Fluss (KoordinatenExtern => NeueKoordinatenExtern)
         is
            when KartenGrundDatentypen.Leer_Grund_Enum =>
               null;

            when others =>
               return Straße_Fluss_Enum;
         end case;

      else
         null;
      end if;
      
      return Leer_Enum;
      
   end StraßeUndFlussPrüfen;

end BewegungBerechnen;
