pragma SPARK_Mode (On);

with GlobaleVariablen;

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

end KIPruefungen;
