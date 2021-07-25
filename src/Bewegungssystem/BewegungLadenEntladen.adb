pragma SPARK_Mode (On);

with UmgebungErreichbarTesten;

package body BewegungLadenEntladen is

   procedure TransporterBeladen
     (LadungExtern, TransporterExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
                                          
      TransporterSchleife:
      for FreierPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
        
         case
           GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).Transportiert (FreierPlatzSchleifenwert)
         is
            when 0 =>
               FreierPlatzNummer := FreierPlatzSchleifenwert;
               exit TransporterSchleife;
               
            when others =>
               null;
         end case;
         
      end loop TransporterSchleife;
      
      GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).Transportiert (FreierPlatzNummer) := LadungExtern.Platznummer;
      GlobaleVariablen.EinheitenGebaut (LadungExtern.Rasse, LadungExtern.Platznummer).Bewegungspunkte := 0.00;
      GlobaleVariablen.EinheitenGebaut (LadungExtern.Rasse, LadungExtern.Platznummer).Position
        := GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).Position;
      GlobaleVariablen.EinheitenGebaut (LadungExtern.Rasse, LadungExtern.Platznummer).WirdTransportiert := TransporterExtern.Platznummer;
      
      -- Hier korrigieren!!!
      case
        EinheitAusladen
      is
         when 0 =>
            null;
            
         when others =>
            EinheitAusTransporterEntfernen (EinheitRasseNummerExtern  => TransporterExtern,
                                            AuszuladendeEinheitExtern => LadungExtern.Platznummer);
      end case;
      
      GlobaleVariablen.CursorImSpiel (LadungExtern.Rasse).Position := GlobaleVariablen.EinheitenGebaut (LadungExtern.Rasse, LadungExtern.Platznummer).Position;
      
   end TransporterBeladen;
   
   
   
   procedure EinheitAusTransporterEntfernen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AuszuladendeEinheitExtern : in GlobaleDatentypen.MaximaleEinheiten)
   is begin
      
      TransporterLeerenSchleife:
      for TransporterLeerenSchleifenwert in GlobaleRecords.TransporterArray'Range loop

         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, AuszuladendeEinheitExtern).Transportiert (TransporterLeerenSchleifenwert) = EinheitRasseNummerExtern.Platznummer
         then
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, AuszuladendeEinheitExtern).Transportiert (TransporterLeerenSchleifenwert) := 0;
            -- Hier nicht WirdTransportiert auf 0 setzen, da das zu Problemen bei Verschiebungen von Transporter zu Transporter führen kann.
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
      for TransporterUmladenSchleifenwert in GlobaleRecords.TransporterArray'Range loop
               
         case
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (TransporterUmladenSchleifenwert)
         is
            when 0 =>
               null;
                     
            when others =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert
                                                 (TransporterUmladenSchleifenwert)).Position := NeuePositionExtern;
         end case;
               
      end loop TransporterUmladenSchleife;
      
   end TransporterladungVerschieben;
   
   
   
   procedure TransporterStadtEntladen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
            
      BelegterPlatzSchleife:
      for BelegterPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
         
         case
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert)
         is
            when 0 =>
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
                                                   EinheitRasseNummerExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert)).WirdTransportiert := 0;
         end case;
      
      end loop BelegterPlatzSchleife;
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert := (others => 0);
      
   end TransporterStadtEntladen;

end BewegungLadenEntladen;
