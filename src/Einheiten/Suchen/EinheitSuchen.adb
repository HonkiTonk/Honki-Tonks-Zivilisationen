pragma SPARK_Mode (On);

with EinheitenKonstanten;

with LeseEinheitenGebaut;

package body EinheitSuchen is

   -- Zu beachten, wenn die Einheit sich in einem Transporter befindet, dann wird immer die Nummer des Transporters zurückgegeben.
   function KoordinatenEinheitMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         if
           LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) /= KoordinatenExtern
         then
            null;
               
         elsif
           LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) = EinheitenKonstanten.LeerWirdTransportiert
         then
            return EinheitNummerSchleifenwert;
                  
         else
            return LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert));
         end if;
         
      end loop EinheitSchleife;
      
      return EinheitenKonstanten.LeerNummer;
      
   end KoordinatenEinheitMitRasseSuchen;
   


   -- Zu beachten, wenn die Einheit sich in einem Transporter befindet, dann wird immer die Nummer des Transporters zurückgegeben.
   function KoordinatenEinheitOhneRasseSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               EinheitNummer := KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseSchleifenwert,
                                                                  KoordinatenExtern => KoordinatenExtern);
               if
                 EinheitNummer = EinheitenKonstanten.LeerNummer
               then
                  null;
                  
               else
                  return (RasseSchleifenwert, EinheitNummer);
               end if;
         end case;
         
      end loop RasseSchleife;
      
      return EinheitenKonstanten.LeerRasseNummer;
      
   end KoordinatenEinheitOhneRasseSuchen;



   -- Sucht ohne die Rasse die hineingegeben wird.
   -- Zu beachten, wenn die Einheit sich in einem Transporter befindet, dann wird immer die Nummer des Transporters zurückgegeben.
   function KoordinatenEinheitOhneSpezielleRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseExtern = RasseSchleifenwert
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
           
         else
            EinheitNummer := KoordinatenEinheitMitRasseSuchen (RasseExtern       => RasseSchleifenwert,
                                                               KoordinatenExtern => KoordinatenExtern);
            case
              EinheitNummer
            is
               when EinheitenKonstanten.LeerNummer =>
                  null;
                  
               when others =>
                  return (RasseSchleifenwert, EinheitNummer);
            end case;
         end if;
         
      end loop RasseSchleife;
      
      return EinheitenKonstanten.LeerRasseNummer;
      
   end KoordinatenEinheitOhneSpezielleRasseSuchen;

end EinheitSuchen;
