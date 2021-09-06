pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body EinheitSuchen is

   function KoordinatenEinheitMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert))
         is
            when GlobaleKonstanten.LeerEinheitenID =>
               null;
               
            when others =>
               if
                 LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) = KoordinatenExtern
               then
                  return EinheitNummerSchleifenwert;
            
               else
                  null;
               end if;
         end case;
         
      end loop EinheitSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end KoordinatenEinheitMitRasseSuchen;



   function KoordinatenTransporterMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert))
         is
            when GlobaleKonstanten.LeerEinheitenID =>
               null;
               
            when others =>
               if
                 LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) = KoordinatenExtern
                 and
                   LeseEinheitenDatenbank.KannTransportieren (RasseExtern => RasseExtern,
                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)))
                 /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
               then
                  return EinheitNummerSchleifenwert;
            
               else
                  null;
               end if;
         end case;
         
      end loop EinheitSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end KoordinatenTransporterMitRasseSuchen;



   -- Zu beachten, wenn die Einheit sich in einem Transporter befindet, dann wird immer die Nummer des Transporters zurückgegeben.
   function KoordinatenEinheitOhneRasseSuchen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               EinheitSchleife:
               for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
            
                  if
                    LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert)) = GlobaleKonstanten.LeerEinheitenID
                  then
                     null;
                     
                  elsif
                    LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert)) = KoordinatenExtern
                  then
                     case
                       LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert))
                     is
                        when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
                           return (RasseSchleifenwert, EinheitNummerSchleifenwert);
                  
                        when others =>
                           return (RasseSchleifenwert, LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert)));
                     end case;
               
                  else
                     null;
                  end if;
            
               end loop EinheitSchleife;
         end case;
         
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
   end KoordinatenEinheitOhneRasseSuchen;



   -- Sucht ohne die Rasse die hineingegeben wird.
   function KoordinatenEinheitOhneSpezielleRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (1) loop
         
         if
           RasseExtern = RasseSchleifenwert
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
           
         else
            EinheitSchleife:
            for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop

               case
                 LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert))
               is
                  when GlobaleKonstanten.LeerEinheitenID =>
                     null;
                     
                  when others =>
                     if
                       LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert)) = KoordinatenExtern
                     then
                        return (RasseSchleifenwert, EinheitNummerSchleifenwert);
               
                     else
                        null;
                     end if;
               end case;
            
            end loop EinheitSchleife;
         end if;
         
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
   end KoordinatenEinheitOhneSpezielleRasseSuchen;



   function EinheitAufTransporterSuchen
     (TransporterExtern : in GlobaleRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin

      TransporterSchleife:
      for TransporterPlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop
         
         if
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                              PlatzExtern              => TransporterPlatzSchleifenwert) = LadungExtern
         then
            return TransporterPlatzSchleifenwert;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end EinheitAufTransporterSuchen;



   function HatTransporterLadung
     (EinheitRassePlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      TransporterSchleife:
      for TransporterPlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRassePlatznummerExtern.Rasse,
                                                                                                                                IDExtern    =>
                                                                                                                                  LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRassePlatznummerExtern)) loop
         
         if
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRassePlatznummerExtern,
                                              PlatzExtern              => TransporterPlatzSchleifenwert) /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
         then
            return True;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return False;
      
   end HatTransporterLadung; 

end EinheitSuchen;
