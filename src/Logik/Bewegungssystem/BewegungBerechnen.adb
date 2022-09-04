pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with EinheitenKonstanten;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with StadtKonstanten;

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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      LadungVerschieben := False;

      -- Immer berücksichtigen dass in BewegungssystemEinheiten.BewegungPrüfen bereits geprüft wird ob der Transporter die Einheit transportieren kann und ein freier Platz vorhanden ist.
      if
        EinheitenKonstanten.LeerKannTransportieren = LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      then
         null;
         
      elsif
        StadtKonstanten.LeerNummer = StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                 KoordinatenExtern => NeueKoordinatenExtern)
      then
         -- Die Ladungsverschiebung muss mit dem neuen Karten/Einheitenkoordinatensystem immer am Schluss erfolgen.
         -- Theoretisch hätte das auch immer im alten System passieren müssen, um zu verhidnern dass die Ladung verschoben wird ohne dass das Schiff verschoben werden kann.
         -- Kam nur nie zu einem Problem weil es keinen Bewegungsabzug für Schiffe gab.
         LadungVerschieben := True;

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
                                                  BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
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
                                                                  LadungExtern      => EinheitRasseNummerExtern.Nummer);
      end case;
      
      case
        SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when RassenDatentypen.KI_Spieler_Enum =>
            null;
            
         when others =>
            SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAktuell := NeueKoordinatenExtern;
      end case;
      
      SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           KoordinatenExtern        => NeueKoordinatenExtern);
      
      case
        LadungVerschieben
      is
         when True =>
            BewegungLadenEntladen.TransporterladungVerschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                NeueKoordinatenExtern    => NeueKoordinatenExtern);
            
         when False =>
            null;
      end case;
      
      NachBewegung (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                    EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end BewegungEinheitenBerechnung;
   
   
   
   procedure NachBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Prüft nur ob das Feld auf dass sich diese Einheit bewegt bereits von einer anderen Rasse aufgedeckt wurde und stellt entsprechend Kontakt her.
      KontaktSchleife:
      for FremdeSichtbarkeitSchleifenwert in RassenDatentypen.RassenImSpielArray'Range loop
         
         if
           FremdeSichtbarkeitSchleifenwert = EinheitRasseNummerExtern.Rasse
           or
             SpielVariablen.RassenImSpiel (FremdeSichtbarkeitSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           True = LeseKarten.Sichtbar (KoordinatenExtern => NeueKoordinatenExtern,
                                       RasseExtern       => FremdeSichtbarkeitSchleifenwert)
         then
            KennenLernen.Erstkontakt (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                      FremdeRasseExtern => FremdeSichtbarkeitSchleifenwert);
            
         else
            null;
         end if;
         
      end loop KontaktSchleife;
      
   end NachBewegung;
   
      
   
   function AbzugDurchBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.BewegungFloat
   is begin
      
      Welchen_Bonus := StraßeUndFlussPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               NeueKoordinatenExtern    => NeueKoordinatenExtern);

      case
        LeseKarten.AktuellerGrund (KoordinatenExtern => NeueKoordinatenExtern)
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Gebirge_Enum | KartengrundDatentypen.Dschungel_Enum | KartengrundDatentypen.Sumpf_Enum =>
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Bewegungsbonuse_Enum
   is begin

      if
        False = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                       WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
        and
          False = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                         IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                         WelcheUmgebungExtern => EinheitenDatentypen.Weltraum_Enum)
      then
         case
           LeseKarten.Weg (KoordinatenExtern => NeueKoordinatenExtern)
         is
            when KartenverbesserungDatentypen.Karten_Straße_Enum'Range =>
               return Straße_Fluss_Enum;
               
            when KartenverbesserungDatentypen.Karten_Schiene_Enum'Range =>
               return Schiene_Enum;
               
            when KartenverbesserungDatentypen.Karten_Tunnel_Enum =>
               return Straße_Fluss_Enum;
                  
            when others =>
               null;
         end case;

         case
           LeseKarten.Fluss (KoordinatenExtern => NeueKoordinatenExtern)
         is
            when KartengrundDatentypen.Leer_Fluss_Enum =>
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
