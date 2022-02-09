pragma SPARK_Mode (On);

with KarteSFML;
with KarteKonsole;
with CursorPlatzierenSFML;
with CursorAltPlatzieren;

package body Karte is

   procedure AnzeigeKarte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- CursorPositionAltFestlegen braucht eine aktuelle Cursor Position. Kann man aber bestimmt trotzdem optimieren.
      CursorPlatzierenSFML.CursorPlatzierenKarteSFML (RasseExtern => RasseExtern);
      CursorAltPlatzieren.CursorAltPlatzieren (RasseExtern => RasseExtern);
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            KarteKonsole.AnzeigeKarteKonsole (RasseExtern => RasseExtern);
            
         when SystemDatentypen.Grafik_SFML =>
            KarteSFML.KarteAnzeigen (RasseExtern => RasseExtern);
      end case;

   end AnzeigeKarte;
   
end Karte;
