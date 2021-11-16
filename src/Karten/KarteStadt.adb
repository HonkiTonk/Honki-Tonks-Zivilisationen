pragma SPARK_Mode (On);

with KarteStadtKonsole;
with KarteStadtSFML;

package body KarteStadt is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            KarteStadtKonsole.AnzeigeStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when SystemDatentypen.Beides =>
           -- KarteStadtKonsole.AnzeigeStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            KarteStadtSFML.AnzeigeStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when SystemDatentypen.SFML =>
            KarteStadtSFML.AnzeigeStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end AnzeigeStadt;

end KarteStadt;
