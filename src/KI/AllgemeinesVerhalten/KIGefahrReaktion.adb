pragma SPARK_Mode (On);

with KIStadtSuchen;

package body KIGefahrReaktion is

   procedure KIGefahrReaktion
     (EinheitRasseNummerExtern, FeindlicheEinheit : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      ZielStadt := KIStadtSuchen.NähesteStadtSuchen (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                                      AnfangKoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position);
      
      case
        ZielStadt.XAchse
      is
         when 0 =>
            null;
            
         when others =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := ZielStadt;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Nicht_Vorhanden;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger := GlobaleDatentypen.Nicht_Vorhanden;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 0;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := 0;
            -- GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Flucht;
      end case;
      
   end KIGefahrReaktion;

end KIGefahrReaktion;
