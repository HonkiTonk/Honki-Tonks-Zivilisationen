pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikTonDatentypen;

with KarteStadtKonsole;
with KarteStadtSFML;
with CursorPlatzierenSFML;

package body KarteStadt is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      CursorPlatzierenSFML.CursorPlatzierenStadtSFML (RasseExtern => StadtRasseNummerExtern.Rasse);
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            KarteStadtKonsole.AnzeigeStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GrafikTonDatentypen.Grafik_SFML_Enum =>
            KarteStadtSFML.AnzeigeStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end AnzeigeStadt;

end KarteStadt;
