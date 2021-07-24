pragma SPARK_Mode (On);

with EinheitSuchen, KartePositionPruefen, UmgebungErreichbarTesten;

package body BewegungLadenEntladen is

   procedure TransporterBeladen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
   is begin
      
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                  ÄnderungExtern       => ÄnderungExtern);
      
      TransporterNummer := EinheitSuchen.KoordinatenTransporterMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                               KoordinatenExtern => KartenWert);
      
      EinheitAusladen := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert;
                                          
      TransporterSchleife:
      for FreierPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
        
         case
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).Transportiert (FreierPlatzSchleifenwert)
         is
            when 0 =>
               FreierPlatzNummer := FreierPlatzSchleifenwert;
               exit TransporterSchleife;
               
            when others =>
               null;
         end case;
         
      end loop TransporterSchleife;
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).Transportiert (FreierPlatzNummer) := EinheitRasseNummerExtern.Platznummer;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := 0.00;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position
        := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).Position;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert := TransporterNummer;
      
      case
        EinheitAusladen
      is
         when 0 =>
            null;
            
         when others =>
            EinheitAusTransporterEntfernen (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                            AuszuladendeEinheitExtern => EinheitAusladen);
      end case;
      
      GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Position := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position;
      
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
