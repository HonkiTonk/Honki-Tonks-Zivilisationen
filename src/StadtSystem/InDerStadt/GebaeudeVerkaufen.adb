pragma SPARK_Mode (On);

with LeseStadtGebaut;

with StadtProduktion, GebaeudeAllgemein;

package body GebaeudeVerkaufen is

   procedure GebäudeVerkaufen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse = 1
         or
           GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse = 2)
        and
          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse < 13
      then
         Aufschlag := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse;
         
      else
         Aufschlag := 0;
      end if;
        
      case
        Aufschlag
      is
         when 0 =>
            null;
            
         when others =>
            Aufschlag := Aufschlag - 1;
            if
              LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 WelchesGebäudeExtern  => GlobaleDatentypen.GebäudeID ((GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse) + Aufschlag * 12))
                = False
            then
               null;
                        
            else
               GebaeudeAllgemein.GebäudeEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   WelchesGebäudeExtern   => GlobaleDatentypen.GebäudeID ((GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse) + Aufschlag * 12));
               StadtProduktion.StadtProduktionPrüfen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            end if;
      end case;
      
   end GebäudeVerkaufen;

end GebaeudeVerkaufen;
