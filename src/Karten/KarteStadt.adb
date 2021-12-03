pragma SPARK_Mode (On);

with KarteStadtKonsole;
with KarteStadtSFML;
with BewegungCursorSFML;

package body KarteStadt is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      BewegungCursorSFML.CursorPlatzierenStadtSFML (RasseExtern => StadtRasseNummerExtern.Rasse);
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            KarteStadtKonsole.AnzeigeStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when SystemDatentypen.SFML =>
            KarteStadtSFML.AnzeigeStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end AnzeigeStadt;

end KarteStadt;
