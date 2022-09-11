pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with UmgebungErreichbarTesten;
with TransporterSuchenLogik;

-- Das Verschachteln mehrerer Transporter ineinander sollte keine Probleme mit regulären Einheiten machen.
-- Es muss nur darauf geachtet werden dass in der EinheitenDatenbank das KannTransportieren immer kleiner ist als KannTransportiertWerden.
package body LadungsbewegungLogik is

   procedure TransporterBeladen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
   is begin
      
      FreierPlatzNummer := TransporterSuchenLogik.FreierPlatz (TransporterExtern => TransporterExtern);
      
      case
        FreierPlatzNummer
      is
         when EinheitenDatentypen.Transportplätze'First =>
            null;
            
         when others =>
            if
              LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern)) /= EinheitenKonstanten.LeerWirdTransportiert
            then
               EinheitAusTransporterEntfernen (TransporterExtern => (TransporterExtern.Rasse, LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern))),
                                               LadungExtern      => LadungExtern);
         
            else
               null;
            end if;
            
            SchreibeEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                   LadungExtern             => LadungExtern,
                                                   LadungsplatzExtern       => FreierPlatzNummer);
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                     BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                                     RechnenSetzenExtern      => 0);
            SchreibeEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                       TransporterExtern        => TransporterExtern.Nummer);
            NeueKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => TransporterExtern);
            SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                 KoordinatenExtern        => NeueKoordinaten);
            
            TransporterladungVerschieben (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                          NeueKoordinatenExtern    => NeueKoordinaten);
      end case;
      
   end TransporterBeladen;
     
      
   
   procedure EinheitAusTransporterEntfernen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern));
      
      TransporterLeerenSchleife:
      for TransporterLeerenSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop

         if
           LadungExtern = LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                             PlatzExtern              => TransporterLeerenSchleifenwert)
         then
            SchreibeEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                   LadungExtern             => EinheitenKonstanten.LeerTransportiert,
                                                   LadungsplatzExtern       => TransporterLeerenSchleifenwert);
            SchreibeEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                       TransporterExtern        => EinheitenKonstanten.LeerWirdTransportiert);
            exit TransporterLeerenSchleife;
            
         else
            null;
         end if;
               
      end loop TransporterLeerenSchleife;
      
   end EinheitAusTransporterEntfernen;
   
   
   
   procedure TransporterladungVerschieben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      TransporterUmladenSchleife:
      for TransporterUmladenSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
         
         Ladungsnummer := LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             PlatzExtern              => TransporterUmladenSchleifenwert);
         
         case
           Ladungsnummer
         is
            when EinheitenKonstanten.LeerTransportiert =>
               null;
                     
            when others =>
               SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Ladungsnummer),
                                                    KoordinatenExtern        => NeueKoordinatenExtern);
               
               TransporterladungVerschieben (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Ladungsnummer),
                                             NeueKoordinatenExtern    => NeueKoordinatenExtern);
         end case;
               
      end loop TransporterUmladenSchleife;
      
   end TransporterladungVerschieben;
   
   
   
   procedure TransporterStadtEntladen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            
      BelegterPlatzSchleife:
      for BelegterPlatzSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
         
         EinheitnummerStadtprüfung := LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                          PlatzExtern              => BelegterPlatzSchleifenwert);
         case
           EinheitnummerStadtprüfung
         is
            when EinheitenKonstanten.LeerTransportiert =>
               null;
               
            when others =>
               IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitnummerStadtprüfung));
               
               SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitnummerStadtprüfung),
                                                    KoordinatenExtern        => UmgebungErreichbarTesten.UmgebungErreichbarTesten (AktuelleKoordinatenExtern => NeueKoordinatenExtern,
                                                                                                                                   RasseExtern               => EinheitRasseNummerExtern.Rasse,
                                                                                                                                   IDExtern                  => IDEinheit,
                                                                                                                                   NotwendigeFelderExtern    => 1));
               
               SchreibeEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitnummerStadtprüfung),
                                                          TransporterExtern        => EinheitenKonstanten.LeerWirdTransportiert);
         end case;
         
      end loop BelegterPlatzSchleife;
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Transportiert := (others => EinheitenKonstanten.LeerTransportiert);
      
   end TransporterStadtEntladen;

end LadungsbewegungLogik;
