pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen;

with LeseStadtGebaut;

with StadtProduktion;
with GebaeudeAllgemein;

package body GebaeudeVerkaufen is

   procedure GebäudeVerkaufen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        (SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse = 1
         or
           SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse = 2)
        and
          SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse <= 12
      then
         Aufschlag := SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse;
         
      elsif
        SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse = 3
        and
          SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse <= 2
      then
         Aufschlag := SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse;
         
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
                                                 WelchesGebäudeExtern  => EinheitStadtDatentypen.GebäudeID ((SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse) + Aufschlag * 12))
                = False
            then
               null;
                        
            else
               GebaeudeAllgemein.GebäudeEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    WelchesGebäudeExtern   => EinheitStadtDatentypen.GebäudeID ((SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse) + Aufschlag * 12));
               StadtProduktion.StadtProduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
            end if;
      end case;
      
   end GebäudeVerkaufen;

end GebaeudeVerkaufen;
