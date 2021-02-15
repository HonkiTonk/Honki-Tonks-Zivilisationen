pragma SPARK_Mode (On);

with KIVariablen, KIBewegung, KIDatentypen;

package body KIPruefungen is
   
   function EinheitenAbstandBerechnen (EinheitEinsRasseNummer, EinheitZweiRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Natural is
   begin

      if GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummer.Rasse, EinheitEinsRasseNummer.Platznummer).AchsenPosition.EAchse
        = GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummer.Rasse, EinheitZweiRasseNummer.Platznummer).AchsenPosition.EAchse then
         KartenfeldAbstand := abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummer.Rasse, EinheitEinsRasseNummer.Platznummer).AchsenPosition.YAchse
                                   - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummer.Rasse, EinheitZweiRasseNummer.Platznummer).AchsenPosition.YAchse);
         case KartenfeldAbstand is
            when 1 =>
               return 1;

            when others =>
               null;
         end case;

         KartenfeldAbstand := abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummer.Rasse, EinheitEinsRasseNummer.Platznummer).AchsenPosition.XAchse
                                   - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummer.Rasse, EinheitZweiRasseNummer.Platznummer).AchsenPosition.XAchse);
         case KartenfeldAbstand is
            when 1 =>
               return 1;

            when others =>
               null;
         end case;

      elsif abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummer.Rasse, EinheitEinsRasseNummer.Platznummer).AchsenPosition.EAchse
                 - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummer.Rasse, EinheitZweiRasseNummer.Platznummer).AchsenPosition.EAchse) = 1 then
         KartenfeldAbstand := abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummer.Rasse, EinheitEinsRasseNummer.Platznummer).AchsenPosition.YAchse
                                   - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummer.Rasse, EinheitZweiRasseNummer.Platznummer).AchsenPosition.YAchse);
         case KartenfeldAbstand is
            when 0 .. 1 =>
               return 1;

            when others =>
               null;
         end case;

         KartenfeldAbstand := abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummer.Rasse, EinheitEinsRasseNummer.Platznummer).AchsenPosition.XAchse
                                   - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummer.Rasse, EinheitZweiRasseNummer.Platznummer).AchsenPosition.XAchse);
         case KartenfeldAbstand is
            when 0 .. 1 =>
               return 1;

            when others =>
               null;
         end case;

      else
         null;
      end if;
           
      return 10;
      
   end EinheitenAbstandBerechnen;



   procedure ZielBerechnenGefahr (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      RichtungenFeinde := (others => 0);
      Richtung := 0;
      
      YAchseSchleife:
      for YAchse in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
         XAchseSchleife:
         for XAchse in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop

            -- 1 = Norden (-), 2 = Westen (-), 3 = Süden (+), 4 = Osten (+)
            if YAchse < 0 and KIVariablen.FeindlicheEinheiten (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, YAchse, XAchse) /= 0 then
                  RichtungenFeinde (1) := RichtungenFeinde (1) + 1;

            elsif YAchse = 0 and KIVariablen.FeindlicheEinheiten (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, YAchse, XAchse) /= 0 then  
                  RichtungenFeinde (1) := RichtungenFeinde (1) + 1;
                  RichtungenFeinde (3) := RichtungenFeinde (3) + 1;
               
            elsif YAchse > 0 and KIVariablen.FeindlicheEinheiten (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, YAchse, XAchse) /= 0 then 
                  RichtungenFeinde (3) := RichtungenFeinde (3) + 1;
            else
               null;
            end if;

            if XAchse < 0 and KIVariablen.FeindlicheEinheiten (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, YAchse, XAchse) /= 0 then
                  RichtungenFeinde (2) := RichtungenFeinde (2) + 1;

            elsif XAchse = 0 and KIVariablen.FeindlicheEinheiten (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, YAchse, XAchse) /= 0 then  
                  RichtungenFeinde (2) := RichtungenFeinde (2) + 1;
                  RichtungenFeinde (4) := RichtungenFeinde (4) + 1;
               
            elsif XAchse > 0 and KIVariablen.FeindlicheEinheiten (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, YAchse, XAchse) /= 0 then 
                  RichtungenFeinde (4) := RichtungenFeinde (4) + 1;
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;      
      
      -- 1 = Norden (-), 2 = Westen (-), 3 = Süden (+), 4 = Osten (+)
      if RichtungenFeinde (1) /= 0 or RichtungenFeinde (3) /= 0 then
         if RichtungenFeinde (1) > RichtungenFeinde (3) then
            Richtung := 5;

         elsif RichtungenFeinde (1) = RichtungenFeinde (3) then
            null;
         
         else
            Richtung := 1;
         end if;

      else
         null;
      end if;
      
      if RichtungenFeinde (2) /= 0 or RichtungenFeinde (4) /= 0 then
         if RichtungenFeinde (2) > RichtungenFeinde (4) then
            Richtung := 3;

         elsif RichtungenFeinde (2) = RichtungenFeinde (4) then
            null;
            
         else
            Richtung := 7;
         end if;

      else
         null;
      end if;

      -- 1 = Norden = (-1, 0), 2 = Nord_Ost = (-1, 1), 3 = Osten = (0, 1), 4 = Süd_Osten = (1, 1), 5 = Süden = (1, 0), 6 = Süd_West = (1, -1), 7 = Westen = (0, -1), 8 = Nord_West = (-1, -1)
      case Richtung is
         when 0 => -- Sollte niemals dran kommen
            null;
            
         when others =>
            KIBewegung.NeuesZielErmitteln (EinheitRasseNummer => EinheitRasseNummer,
                                           Richtung           => KIDatentypen.Richtung'Val (Richtung));
      end case;            

   end ZielBerechnenGefahr;

end KIPruefungen;
