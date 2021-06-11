pragma SPARK_Mode (On);

with GebaeudeDatenbank;

with StadtProduktion;

package body GebaeudeVerkaufen is

   procedure GebäudeVerkaufen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.YAchse = 1
        and
          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse < 13
      then
         case
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
           (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse))
         is
            when False =>
               null;
                        
            when others =>
               if
                 GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge
                 + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                            GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse)).PreisGeld / 2) 
                 > Integer'Last
               then
                  GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge := Integer'Last;
                  
               else
                  GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge
                    := GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge
                    + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                               GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse)).PreisGeld / 2);
               end if;
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
                 (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse)) := False;
               StadtProduktion.StadtProduktionPrüfen (StadtRasseNummerExtern => StadtRasseNummerExtern);
         end case;
            
      elsif
        GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.YAchse = 2
        and
          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse < 13
      then
         case
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
           (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse) + 12)
         is
            when False =>
               null;
                        
            when others =>
               if
                 GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge
                 + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                            GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse) + 12).PreisGeld / 2)
                 > Integer'Last
               then
                  GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge := Integer'Last;
               
               else
                  GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge := GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuelleGeldmenge
                    + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                               GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse) + 12).PreisGeld / 2);
               end if;
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
                 (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse) + 12) := False;
               StadtProduktion.StadtProduktionPrüfen (StadtRasseNummerExtern => StadtRasseNummerExtern);
         end case;
                  
      else
         null;
      end if;
      
   end GebäudeVerkaufen;

end GebaeudeVerkaufen;
