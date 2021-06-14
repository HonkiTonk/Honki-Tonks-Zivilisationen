pragma SPARK_Mode (On);

with KartenPruefungen;

with EinheitSuchen;

package body BewegungLadenEntladen is

   procedure TransporterBeladen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
   is begin

      KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                              ÄnderungExtern       => ÄnderungExtern,
                                                              ZusatzYAbstandExtern => 0);
      
      TransporterNummer := EinheitSuchen.KoordinatenTransporterMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                               KoordinatenExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
      
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
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte := 0.00;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition
        := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).AchsenPosition;
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
      
      GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).AchsenPosition := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition;
      
   end TransporterBeladen;
   
   
   
   procedure EinheitAusTransporterEntfernen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AuszuladendeEinheitExtern : in GlobaleDatentypen.MaximaleEinheiten)
   is begin
      
      TransporterLeerenSchleife:
      for TransporterPlatzZweiSchleifenwert in GlobaleRecords.TransporterArray'Range loop

         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, AuszuladendeEinheitExtern).Transportiert (TransporterPlatzZweiSchleifenwert) = EinheitRasseNummerExtern.Platznummer
         then
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, AuszuladendeEinheitExtern).Transportiert (TransporterPlatzZweiSchleifenwert) := 0;
            -- Hier nicht den wird Transportiert auf 0 setzen, da das zu Problemen bei Vershiebungen von Transporter zu Transporter führen kann.
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
      
      TransporterEinsSchleife:
      for TransporterPlatzEinsSchleifenwert in GlobaleRecords.TransporterArray'Range loop
               
         case
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (TransporterPlatzEinsSchleifenwert)
         is
            when 0 =>
               null;
                     
            when others =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert
                                                 (TransporterPlatzEinsSchleifenwert)).AchsenPosition := NeuePositionExtern;
         end case;
               
      end loop TransporterEinsSchleife;
      
   end TransporterladungVerschieben;

end BewegungLadenEntladen;
