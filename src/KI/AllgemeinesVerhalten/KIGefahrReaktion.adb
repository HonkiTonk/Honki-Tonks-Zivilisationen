pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIStadtSuchen;

package body KIGefahrReaktion is

   procedure KIGefahrReaktion
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      ZielStadt := KIStadtSuchen.NähesteStadtSuchen (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                                      AnfangKoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        ZielStadt.XAchse
      is
         when GlobaleKonstanten.LeerYXKartenWert =>
            null;
            
         when others =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => ZielStadt);
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
            SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                              BeschäftigungExtern     => GlobaleDatentypen.Nicht_Vorhanden);
            -- Hier das Maximum als Minus übergeben.
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := 0;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := 0;
            -- GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Flucht;
      end case;
      
   end KIGefahrReaktion;

end KIGefahrReaktion;
