pragma SPARK_Mode (On);

with KartenDatentypen, EinheitStadtDatentypen;
use KartenDatentypen;

with LeseStadtGebaut;

with StadtProduktion, GebaeudeAllgemein;

package body GebaeudeVerkaufen is

   procedure GebäudeVerkaufen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse = 1
         or
           GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse = 2)
        and
          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse <= 12
      then
         Aufschlag := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse;
         
      elsif
        GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse = 3
        and
          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse <= 2
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
                                                 WelchesGebäudeExtern  => EinheitStadtDatentypen.GebäudeID ((GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse) + Aufschlag * 12))
                = False
            then
               null;
                        
            else
               GebaeudeAllgemein.GebäudeEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    WelchesGebäudeExtern   => EinheitStadtDatentypen.GebäudeID ((GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse) + Aufschlag * 12));
               StadtProduktion.StadtProduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
            end if;
      end case;
      
   end GebäudeVerkaufen;

end GebaeudeVerkaufen;
