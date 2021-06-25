pragma SPARK_Mode (On);

with GebaeudeDatenbank;

with StadtProduktion;

package body GebaeudeVerkaufen is

   procedure GebäudeVerkaufen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse = 1
        and
          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse < 13
      then
         case
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
           (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse))
         is
            when False =>
               null;
                        
            when others =>
               if
                 GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Geldmenge
                 + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                            GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse)).PreisGeld / 2) 
                 > Integer'Last
               then
                  GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Geldmenge := Integer'Last;
                  
               else
                  GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Geldmenge
                    := GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Geldmenge
                    + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                               GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse)).PreisGeld / 2);
               end if;
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
                 (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse)) := False;
               StadtProduktion.StadtProduktionPrüfen (StadtRasseNummerExtern => StadtRasseNummerExtern);
         end case;
            
      elsif
        GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse = 2
        and
          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse < 13
      then
         case
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
           (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse) + 12)
         is
            when False =>
               null;
                        
            when others =>
               if
                 GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Geldmenge
                 + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                            GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse) + 12).PreisGeld / 2)
                 > Integer'Last
               then
                  GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Geldmenge := Integer'Last;
               
               else
                  GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Geldmenge := GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Geldmenge
                    + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse,
                               GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse) + 12).PreisGeld / 2);
               end if;
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
                 (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse) + 12) := False;
               StadtProduktion.StadtProduktionPrüfen (StadtRasseNummerExtern => StadtRasseNummerExtern);
         end case;
                  
      else
         null;
      end if;
      
   end GebäudeVerkaufen;

end GebaeudeVerkaufen;
