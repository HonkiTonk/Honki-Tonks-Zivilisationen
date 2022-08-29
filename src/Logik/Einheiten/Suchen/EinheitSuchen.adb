pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords; use KartenRecords;
with EinheitenKonstanten;

with LeseEinheitenGebaut;

package body EinheitSuchen is

   -- Zu beachten, wenn die Einheit sich in einem Transporter befindet, dann wird immer die Nummer des Transporters zurückgegeben.
   function KoordinatenEinheitMitRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
                  
         if
           LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) /= KoordinatenExtern
         then
            null;
            
         else
            return TransporterverschachtelungDurchgehen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert));
         end if;
         
      end loop EinheitSchleife;
      
      return EinheitenKonstanten.LeerNummer;
      
   end KoordinatenEinheitMitRasseSuchen;
   


   -- Zu beachten, wenn die Einheit sich in einem Transporter befindet, dann wird immer die Nummer des Transporters zurückgegeben.
   function KoordinatenEinheitOhneRasseSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.RasseEinheitnummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
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
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.RasseEinheitnummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseExtern = RasseSchleifenwert
           or
             SpielVariablen.RassenImSpiel (RasseSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
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
   
   
   
   function TransporterverschachtelungDurchgehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.MaximaleEinheiten
   is begin
      
      EinheitnummerTransporter := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      case
        EinheitnummerTransporter
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            return EinheitRasseNummerExtern.Nummer;
                  
         when others =>
            return TransporterverschachtelungDurchgehen (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitnummerTransporter));
      end case;
      
   end TransporterverschachtelungDurchgehen;

end EinheitSuchen;
