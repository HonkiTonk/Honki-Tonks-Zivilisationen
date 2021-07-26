pragma SPARK_Mode (On);

with GlobaleKonstanten;

with UmgebungErreichbarTesten, EinheitenAllgemein;

package body BewegungLadenEntladen is

   procedure TransporterBeladen
     (TransporterExtern : in GlobaleRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheiten)
   is begin
      
      FreierPlatzNummer := GlobaleKonstanten.LeerTransportiertWirdTransportiert;
                                          
      TransporterSchleife:
      for FreierPlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. EinheitenAllgemein.MaximaleTransporterKapazität (TransporterExtern => TransporterExtern) loop
        
         case
           GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).Transportiert (FreierPlatzSchleifenwert)
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
              GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, LadungExtern).WirdTransportiert /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
            then
               EinheitAusTransporterEntfernen (TransporterExtern => (TransporterExtern.Rasse, GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, LadungExtern).WirdTransportiert),
                                               LadungExtern      => LadungExtern);
         
            else
               null;
            end if;
            GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).Transportiert (FreierPlatzNummer) := LadungExtern;
            GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, LadungExtern).Bewegungspunkte := GlobaleKonstanten.LeerEinheit.Bewegungspunkte;
            GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, LadungExtern).Position
              := GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).Position;
            GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, LadungExtern).WirdTransportiert := TransporterExtern.Platznummer;
            GlobaleVariablen.CursorImSpiel (TransporterExtern.Rasse).Position := GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, LadungExtern).Position;
      end case;
      
   end TransporterBeladen;
   
   
   
   procedure EinheitAusTransporterEntfernen
     (TransporterExtern : in GlobaleRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheiten)
   is begin
      
      TransporterLeerenSchleife:
      for TransporterLeerenSchleifenwert in GlobaleRecords.TransporterArray'First .. EinheitenAllgemein.MaximaleTransporterKapazität (TransporterExtern => TransporterExtern) loop

         if
           GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).Transportiert (TransporterLeerenSchleifenwert) = LadungExtern
         then
            GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).Transportiert (TransporterLeerenSchleifenwert) := GlobaleKonstanten.LeerTransportiertWirdTransportiert;
            GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, LadungExtern).WirdTransportiert := GlobaleKonstanten.LeerTransportiertWirdTransportiert;
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
      for TransporterUmladenSchleifenwert in GlobaleRecords.TransporterArray'First .. EinheitenAllgemein.MaximaleTransporterKapazität (TransporterExtern => EinheitRasseNummerExtern) loop
               
         case
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (TransporterUmladenSchleifenwert)
         is
            when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
               null;
                     
            when others =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert
                                                 (TransporterUmladenSchleifenwert)).Position := NeuePositionExtern;
         end case;
               
      end loop TransporterUmladenSchleife;
      
   end TransporterladungVerschieben;
   
   
   
   procedure TransporterStadtEntladen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
            
      BelegterPlatzSchleife:
      for BelegterPlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. EinheitenAllgemein.MaximaleTransporterKapazität (TransporterExtern => EinheitRasseNummerExtern) loop
         
         case
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert)
         is
            when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
               null;
                              
            when others =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,
                                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,
                                                   EinheitRasseNummerExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert)).Position
                 := UmgebungErreichbarTesten.UmgebungErreichbarTesten (AktuelleKoordinatenExtern => NeuePositionExtern,
                                                                       RasseExtern               => EinheitRasseNummerExtern.Rasse,
                                                                       IDExtern                  => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,
                                                                         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,
                                                                           EinheitRasseNummerExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert)).ID,
                                                                       NotwendigeFelderExtern    => 1);
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,
                                                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,
                                                   EinheitRasseNummerExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert)).WirdTransportiert := GlobaleKonstanten.LeerTransportiertWirdTransportiert;
         end case;
      
      end loop BelegterPlatzSchleife;
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert := (others => GlobaleKonstanten.LeerTransportiertWirdTransportiert);
      
   end TransporterStadtEntladen;

end BewegungLadenEntladen;
