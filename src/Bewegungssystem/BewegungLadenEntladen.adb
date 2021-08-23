pragma SPARK_Mode (On);

with GlobaleKonstanten;

with UmgebungErreichbarTesten, LeseEinheitenGebaut, SchreibeEinheitenGebaut, LeseEinheitenDatenbank;

package body BewegungLadenEntladen is

   procedure TransporterBeladen
     (TransporterExtern : in GlobaleRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheiten)
   is begin
      
      FreierPlatzNummer := GlobaleKonstanten.LeerTransportiertWirdTransportiert;
                                          
      TransporterSchleife:
      for FreierPlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop
        
         case
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                              PlatzExtern              => FreierPlatzSchleifenwert)
         is
            when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
               FreierPlatzNummer := FreierPlatzSchleifenwert;
               exit TransporterSchleife;
               
            when others =>
               null;
         end case;
         
      end loop TransporterSchleife;      
      
      case
        FreierPlatzNummer
      is
         when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
            null;
            
         when others =>
            if
              LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern)) /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
            then
               EinheitAusTransporterEntfernen (TransporterExtern => (TransporterExtern.Rasse, LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern))),
                                               LadungExtern      => LadungExtern);
         
            else
               null;
            end if;
            SchreibeEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                   LadungExtern             => LadungExtern,
                                                   LadungspositionExtern    => FreierPlatzNummer);
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                     BewegungspunkteExtern    => GlobaleKonstanten.LeerEinheit.Bewegungspunkte,
                                                     RechnenSetzenExtern      => 0);
            SchreibeEinheitenGebaut.Position (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                              PositionExtern           => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => TransporterExtern));
            SchreibeEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                       TransporterExtern        => TransporterExtern.Platznummer);
            GlobaleVariablen.CursorImSpiel (TransporterExtern.Rasse).Position := LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern));
      end case;
      
   end TransporterBeladen;
   
   
   
   procedure EinheitAusTransporterEntfernen
     (TransporterExtern : in GlobaleRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheiten)
   is begin
      
      TransporterLeerenSchleife:
      for TransporterLeerenSchleifenwert in GlobaleRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                                                 IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop

         if
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                              PlatzExtern              => TransporterLeerenSchleifenwert) = LadungExtern
         then
            SchreibeEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                   LadungExtern             => GlobaleKonstanten.LeerTransportiertWirdTransportiert,
                                                   LadungspositionExtern    => TransporterLeerenSchleifenwert);
            SchreibeEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                       TransporterExtern        => GlobaleKonstanten.LeerTransportiertWirdTransportiert);
            exit TransporterLeerenSchleife;
                     
         else
            null;
         end if;
               
      end loop TransporterLeerenSchleife;
      
   end EinheitAusTransporterEntfernen;
   
   
   
   procedure TransporterladungVerschieben
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      TransporterUmladenSchleife:
      for TransporterUmladenSchleifenwert in GlobaleRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                  IDExtern    =>
                                                                                                                                    LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) loop
               
         case
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              PlatzExtern              => TransporterUmladenSchleifenwert)
         is
            when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
               null;
                     
            when others =>
               SchreibeEinheitenGebaut.Position (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                 PlatzExtern              => TransporterUmladenSchleifenwert)),
                                                 PositionExtern           => NeuePositionExtern);
         end case;
               
      end loop TransporterUmladenSchleife;
      
   end TransporterladungVerschieben;
   
   
   
   procedure TransporterStadtEntladen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
            
      BelegterPlatzSchleife:
      for BelegterPlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                             IDExtern    =>
                                                                                                                               LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) loop
         
         case
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              PlatzExtern              => BelegterPlatzSchleifenwert)
         is
            when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
               null;
                              
            when others =>
               SchreibeEinheitenGebaut.Position (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                 PlatzExtern              => BelegterPlatzSchleifenwert)),
                                                 PositionExtern           =>
                                                    UmgebungErreichbarTesten.UmgebungErreichbarTesten (AktuelleKoordinatenExtern => NeuePositionExtern,
                                                                                                       RasseExtern               => EinheitRasseNummerExtern.Rasse,
                                                                                                       IDExtern                  =>
                                                                                                          LeseEinheitenGebaut.ID (EinheitRasseNummerExtern =>
                                                                                                                                    (EinheitRasseNummerExtern.Rasse,
                                                                                                                                     LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                                        PlatzExtern              =>
                                                                                                                                                                           BelegterPlatzSchleifenwert))),
                                                                                                       NotwendigeFelderExtern    => 1));
               SchreibeEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                          PlatzExtern              => BelegterPlatzSchleifenwert)),
                                                          TransporterExtern        => GlobaleKonstanten.LeerTransportiertWirdTransportiert);
         end case;
         
      end loop BelegterPlatzSchleife;
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert := (others => GlobaleKonstanten.LeerTransportiertWirdTransportiert);
      
   end TransporterStadtEntladen;

end BewegungLadenEntladen;
