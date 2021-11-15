pragma SPARK_Mode (On);

with BefehleKonsole;
with BefehleSFML;

package body BefehleImSpiel is

   function Befehle
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            return BefehleKonsole.BefehleKonsole (RasseExtern => RasseExtern);
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            return BefehleSFML.BefehleSFML (RasseExtern => RasseExtern);
      end case;
      
   end Befehle;

end BefehleImSpiel;
