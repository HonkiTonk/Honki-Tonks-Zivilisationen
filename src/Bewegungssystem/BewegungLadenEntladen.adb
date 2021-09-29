pragma SPARK_Mode (On);

with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut, LeseEinheitenDatenbank;

with UmgebungErreichbarTesten;

package body BewegungLadenEntladen is

   procedure TransporterBeladen
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheiten)
   is begin
      
      FreierPlatzNummer := FreienPlatzErmitteln (TransporterExtern => TransporterExtern);
      
      case
        FreierPlatzNummer
      is
         when EinheitenKonstanten.LeerTransportiert =>
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
                                                   LadungspositionExtern    => FreierPlatzNummer);
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                     BewegungspunkteExtern    => EinheitenKonstanten.LeerEinheit.Bewegungspunkte,
                                                     RechnenSetzenExtern      => 0);
            SchreibeEinheitenGebaut.Position (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                              PositionExtern           => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => TransporterExtern));
            SchreibeEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                       TransporterExtern        => TransporterExtern.Platznummer);
            GlobaleVariablen.CursorImSpiel (TransporterExtern.Rasse).Position := LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern));
      end case;
      
   end TransporterBeladen;
   
   
   
   function FreienPlatzErmitteln
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      TransporterSchleife:
      for FreierPlatzSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop
        
         case
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                              PlatzExtern              => FreierPlatzSchleifenwert)
         is
            when EinheitenKonstanten.LeerTransportiert =>
               return FreierPlatzSchleifenwert;
               
            when others =>
               null;
         end case;
         
      end loop TransporterSchleife;
      
      return EinheitenKonstanten.LeerWirdTransportiert;
      
   end FreienPlatzErmitteln;
     
      
   
   procedure EinheitAusTransporterEntfernen
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheiten)
   is begin
      
      TransporterLeerenSchleife:
      for
        TransporterLeerenSchleifenwert
      in
        EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                  IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop

         if
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                              PlatzExtern              => TransporterLeerenSchleifenwert)
           = LadungExtern
         then
            SchreibeEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                   LadungExtern             => EinheitenKonstanten.LeerTransportiert,
                                                   LadungspositionExtern    => TransporterLeerenSchleifenwert);
            SchreibeEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                       TransporterExtern        => EinheitenKonstanten.LeerWirdTransportiert);
            exit TransporterLeerenSchleife;
                     
         else
            null;
         end if;
               
      end loop TransporterLeerenSchleife;
      
   end EinheitAusTransporterEntfernen;
   
   
   
   procedure TransporterladungVerschieben
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      TransporterUmladenSchleife:
      for TransporterUmladenSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                       IDExtern    =>
                                                                                                                                         LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) loop
               
         case
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              PlatzExtern              => TransporterUmladenSchleifenwert)
         is
            when EinheitenKonstanten.LeerTransportiert =>
               null;
                     
            when others =>
               SchreibeEinheitenGebaut.Position (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                 PlatzExtern              => TransporterUmladenSchleifenwert)),
                                                 PositionExtern           => NeuePositionExtern);
         end case;
               
      end loop TransporterUmladenSchleife;
      
   end TransporterladungVerschieben;
   
   
   
   procedure TransporterStadtEntladen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
            
      BelegterPlatzSchleife:
      for BelegterPlatzSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                  IDExtern    =>
                                                                                                                                    LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) loop
         
         case
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              PlatzExtern              => BelegterPlatzSchleifenwert)
         is
            when EinheitenKonstanten.LeerTransportiert =>
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
                                                          TransporterExtern        => EinheitenKonstanten.LeerWirdTransportiert);
         end case;
         
      end loop BelegterPlatzSchleife;
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert := (others => EinheitenKonstanten.LeerTransportiert);
      
   end TransporterStadtEntladen;

end BewegungLadenEntladen;
